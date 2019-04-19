//
//  FlickrPresenter.m
//  NSUrlRequestProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "FlickrPresenter.h"
#import "NetworkService.h"


@implementation FlickrPresenter 

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		//Инициализация
		//Подготовим сервис
		_networkService = [NetworkService initWithUrlConfiguration:nil];
		_networkService.outputDelegate = self;
	}
	return self;
}


#pragma FlickrViewProtocol

/**
 Нажата кнопка поиска
 Проверяем, что там только английские буквы и цифры, иначе алерт
 
 @param searchText текст поиска
 */
- (void)searchActionStartWithSearchText:(NSString *)searchText
{
	NSCharacterSet *englishLettersWithNumbers = [NSCharacterSet characterSetWithCharactersInString: @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"];

	NSCharacterSet *notLetters = [englishLettersWithNumbers invertedSet];
	NSRange range = [searchText rangeOfCharacterFromSet:notLetters];
	if (range.location == NSNotFound)
	{
		[self.networkService findFlickrPhotoWithSearchString:searchText];
	}
	else
	{
		[self.flickrView showAlertWithTitle:@"Неправильный формат" message:@"Можно использовать только английский алфавит и цифры."];
	}
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
		[self.flickrView setImageWithData:imageData atNumber:number];
	}
}

/**
 Сообщает сколько всего изображений будет, чтобы подготовить массив (так как изображения могут прийти в любом порядке)
 
 @param count Количество изображений
 */
- (void)prepareArrayForImagesCount:(NSInteger)count
{
	[self.flickrView setImageArrayCount:count];
}

@end
