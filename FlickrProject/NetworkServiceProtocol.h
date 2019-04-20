//
//  NetworkServiceProtocol.h
//  FlickrProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


/**
 Протокол для вывода результатов работы сервиса
 */
@protocol NetworkServiceOutputProtocol <NSObject>

/**
 Уведомляет View, когда загрузка завершена

 @param imageData Данные изображения
 @param number Номер этого изображения (ячейка)
 */
- (void)loadingImageFinishedWith:(NSData*)imageData atNumber:(NSInteger)number;


/**
 Сообщает сколько всего изображений будет, чтобы подготовить массив (так как изображения могут прийти в любом порядке)

 @param count Количество изображений
 */
- (void)prepareArrayForImagesCount:(NSInteger)count;

@end


/**
 Протокол для функций сервиса
 */
@protocol NetworkServiceInputProtocol <NSObject>

/**
 Инициализирует URLSession с параметрами, можно nil

 @param params Параметры сессии, можно nil
 */
- (void)configureUrlSessionWithParams:(NSDictionary *)params;


/**
 Поиск изображений в сервисе

 @param searchSrting Строка поиска, на английском обязательно
 */
- (void)findFlickrPhotoWithSearchString:(NSString *)searchSrting;


/**
 Отменяет все текущие задания по загрузке изображений
 Вызывается перед новым поиском
 */
- (void)cancelCurrentDownloadTasks;

@end
