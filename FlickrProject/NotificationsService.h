//
//  NotificationsService.h
//  FlickrProject
//
//  Created by Александр Плесовских on 20/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


@interface NotificationsService : NSObject

/**
 Создает запрос на основе данных и добавляет действия
 
 @param seconds Через сколько секунд срабатывание уведомления
 @param title Заголовок уведомления
 @param searchText Текст для поиска в userData уведомления
 */
- (void) sendLocalNotificationAfterSeconds:(NSInteger)seconds withTitle:(NSString *)title andSearchText:(NSString *)searchText;

@end

NS_ASSUME_NONNULL_END
