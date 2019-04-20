//
//  NetworkService.m
//  FlickrProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "NetworkService.h"
#import "NetworkHelper.h"
#import "ImageRequest.h"


const NSInteger imagesPerPage = 20;


@interface NetworkService ()

@property (nonatomic, strong) NSURLSession *urlSession; /**< Сессия */
@property (nonatomic, strong) NSMutableArray<NSURLSessionDownloadTask *> *downloadTasksArray; /**< Массив для заданий подгрузки картинок, нужен для отмены заданий */

@end


@implementation NetworkService

+ (instancetype)initWithUrlConfiguration:(NSDictionary *)params
{
	NetworkService *service = [NetworkService new];
	[service configureUrlSessionWithParams:params];
	service.downloadTasksArray = [NSMutableArray new];
	return service;
}

- (void)configureUrlSessionWithParams:(NSDictionary *)params
{
	NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
	
	// Настраиваем Session Configuration
	[sessionConfiguration setAllowsCellularAccess:YES];
	if (params)
	{
		[sessionConfiguration setHTTPAdditionalHeaders:params];
	}
	else
	{
		[sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json" }];
	}
	
	// Создаем сессию
	self.urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
}


/**
 Загружает изображение по запросу

 @param request Модель запроса
 @param number Номер изображения, для View потом нужен
 */
- (void)loadImageFromRequest:(ImageRequest*) request atNumber:(NSInteger)number;
{
	if (!self.urlSession)
	{
		NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
		self.urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
	}
	
	NSURL *url = [NSURL URLWithString:[request getURLString]];
	NSURLSessionDownloadTask *downloadTask = [self.urlSession downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
	{
		//Получили данные
		NSData *data = [NSData dataWithContentsOfURL:location];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			// Отсюда отправим сообщение на обновление UI с главного потока
			[self.outputDelegate loadingImageFinishedWith:data atNumber:number];
		});
	}];
	
	[self.downloadTasksArray addObject:downloadTask];
	
	[downloadTask resume];
}

 - (void)cancelCurrentDownloadTasks
{
	for (NSURLSessionDownloadTask *task in self.downloadTasksArray)
	{
		if (task.state == NSURLSessionTaskStateRunning)
		{
			[task cancel];
		}
	}
	[self.downloadTasksArray removeAllObjects];
}

- (void)findFlickrPhotoWithSearchString:(NSString *)searchSrting andPage:(NSInteger)page
{
	if (page == 1)
	{
		//Отменим все текущие загрузки, если они есть
		[self cancelCurrentDownloadTasks];
	}
	
	NSString *urlString = [NetworkHelper URLForSearchString:searchSrting andPage:page];
        
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15];
    
    NSURLSession *session;
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
	{
        NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
		//Проверяем статус
		if ([temp[@"stat"] isEqual: @"ok"])
		{
			NSInteger counter = (page - 1) * imagesPerPage;
			NSArray<NSDictionary *> *photos = temp[@"photos"][@"photo"];
			
			// Отсюда отправим сообщение на обновление UI с главного потока
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.outputDelegate prepareArrayForImagesCount: counter + photos.count];
			});
			
			for (NSDictionary *dict in photos)
			{
				// Получение фото
				// https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
				// example https://farm1.staticflickr.com/2/1418878_1e92283336_m.jpg
				NSNumber *farm = dict[@"farm"];
				NSNumber *server = dict[@"server"];
				NSNumber *photo_id = dict[@"id"];
				NSNumber *secret = dict[@"secret"];
				
				NSString *url = [NSString stringWithFormat:
								 @"https://farm%@.staticflickr.com/%@/%@_%@.jpg", farm, server, photo_id, secret];
				ImageRequest *request = [ImageRequest initRequestWithUrl:url forNumber:counter];
				[self loadImageFromRequest:request atNumber:counter];
				counter += 1;
			}
		}
    }];
    [sessionDataTask resume];
}

@end
