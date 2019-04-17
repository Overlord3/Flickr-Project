//
//  FlickerPresenter.m
//  NSUrlRequestProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "FlickerPresenter.h"
#import "NetworkService.h"


@interface FlickerPresenter ()

@property (nonatomic, strong) NetworkService* networkService; /**< Сервис для архитектуры MVP */

@end


@implementation FlickerPresenter 

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		//Инициализация
		//Подготовим сервис
		self.networkService = [NetworkService initWithUrlConfiguration:nil];
		self.networkService.outputDelegate = self;
		
	}
	return self;
}


#pragma FlickerViewProtocol

/**
 Нажата кнопка поиска
 
 @param searchText текст поиска
 */
- (void)searchActionStartWithSearchText:(NSString *)searchText
{
	[self.networkService findFlickrPhotoWithSearchString:searchText];
}


#pragma NetworkServiceProtocol

/**
 Уведомляет View, когда загрузка завершена
 
 @param imageData Данные изображения
 @param number Номер этого изображения (ячейка)
 */
- (void)loadingImageFinishedWith:(NSData*)imageData atNumber:(NSInteger)number
{
	//Проверка, что данные есть
	if (imageData != nil)
	{
		[self.flickerView setImageWithData:imageData atNumber:number];
	}
}

/**
 Сообщает сколько всего изображений будет, чтобы подготовить массив (так как изображения могут прийти в любом порядке)
 
 @param count Количество изображений
 */
- (void)prepareArrayForImagesCount:(NSInteger)count
{
	[self.flickerView setImageArrayCount:count];
}

@end
