//
//  NotificationsService.m
//  FlickrProject
//
//  Created by Александр Плесовских on 20/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "NotificationsService.h"
#import <UserNotifications/UserNotifications.h>


static NSString * const identifierForActions = @"AIPcategory";


@implementation NotificationsService

/**
 Создает запрос на основе данных и добавляет действия
 
 @param seconds Через сколько секунд срабатывание уведомления
 @param title Заголовок уведомления
 @param searchText Текст для поиска в userData уведомления
 */
- (void) sendLocalNotificationAfterSeconds:(NSInteger)seconds withTitle:(NSString *)title andSearchText:(NSString *)searchText
{
	// Создадим Notification Request с контентом и триггером и отправим
	[self scheduleLocalNotificationAfterSeconds:seconds withTitle:title andSearchText:searchText];
	// Добавим действия к этой категории
	[self addCustomActions];
}

/**
 Создает запрос на основе данных

 @param seconds Через сколько секунд срабатывание уведомления
 @param title Заголовок уведомления
 @param searchText Текст для поиска в userData уведомления
 */
- (void)scheduleLocalNotificationAfterSeconds:(NSInteger)seconds withTitle:(NSString *)title andSearchText:(NSString *)searchText
{
	/* Контент - сущность класса UNMutableNotificationContent
	 Содержит в себе:
	 title: Заголовок, обычно с основной причиной показа пуша
	 subtitle: Подзаговолок, не обязателен
	 body: Тело пуша
	 badge: Номер бейджа для указания на иконке приложения
	 sound: Звук, с которым покажется push при доставке. Можно использовать default или установить свой из файла.
	 launchImageName: имя изображения, которое стоит показать, если приложение запущено по тапу на notification.
	 userInfo: Кастомный словарь с данными
	 attachments: Массив UNNotificationAttachment. Используется для включения аудио, видео или графического контента.
	 */
	UNMutableNotificationContent *content = [UNMutableNotificationContent new];
	content.title = @"Напоминание!";
	content.body = title;
	content.sound = [UNNotificationSound defaultSound];
	
	NSDictionary *dict = @{
						   @"searchRequest": searchText
						   };
	content.userInfo = dict;
	
	// Добавляем свою категорию
	content.categoryIdentifier = identifierForActions;
	
	// Создаем триггер
	UNNotificationTrigger *whateverTrigger = [self intervalTriggerAfterSeconds:seconds repeats:NO];
	// Другой тип триггера
	//UNNotificationTrigger *whateverTrigger = [self dateTriggerAfterSecondsFromNow:seconds];
	// Отправка уведомления
	[self sendRequestWithContent:content andTrigger:whateverTrigger];
}


/**
 Генерирует и отправляет запрос с контентом и триггером

 @param content основной контент
 @param trigger условие срабатывания (время)
 */
- (void)sendRequestWithContent:(UNMutableNotificationContent *)content andTrigger:(UNNotificationTrigger *)trigger
{
	NSString *identifier = @"NotificationId";
	UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
	
	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
	[center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
	 {
		 if (error)
		 {
			 NSLog(@"Ошибка - %@",error);
		 }
	 }];
}

#pragma mark Условия срабатывания, Trigger

/**
 Создает триггер на уведомление по интервалу, через N секунд
 
 @param seconds количество секунд с текущей даты
 @param repeat повторять ли уведомление через интервал или нет
 @return Триггер для уведомления
 */
- (UNTimeIntervalNotificationTrigger *)intervalTriggerAfterSeconds:(NSInteger)seconds repeats:(BOOL)repeat
{
	return [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:seconds repeats:repeat];
}


/**
 Создает триггер на уведомление по дате, через N секунд от текущей даты

 @param seconds количество секунд с текущей даты
 @return Триггер для уведомления
 */
- (UNCalendarNotificationTrigger *)dateTriggerAfterSecondsFromNow:(NSInteger)seconds
{
	/* Если мы хотим сделать повторяющийся пуш каждый день в одно время, в dateComponents
	 должны быть только часы/минуты/секунды */
	NSDate *date = [NSDate dateWithTimeIntervalSinceNow:seconds];
	NSDateComponents *triggerDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear + NSCalendarUnitMonth + NSCalendarUnitDay + NSCalendarUnitHour + NSCalendarUnitMinute + NSCalendarUnitSecond fromDate:date];
	
	return [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
}


#pragma mark Добавление действий к уведомлению, Actions

/**
 Добавим основные действия:
 Открыть приложение и Скрыть уведомление
 */
- (void)addCustomActions
{
	UNNotificationAction *checkAction = [UNNotificationAction actionWithIdentifier:@"CheckID" title:@"Открыть приложение" options:UNNotificationActionOptionForeground];
	
	UNNotificationAction *deleteAction = [UNNotificationAction actionWithIdentifier:@"DeleteID" title:@"Скрыть" options:UNNotificationActionOptionDestructive];
	
	// Создаем кастомную категорию
	UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:identifierForActions actions:@[checkAction,deleteAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
	NSSet *categories = [NSSet setWithObject:category];
	
	// Устанавливаем ее для notificationCenter
	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
	[center setNotificationCategories:categories];
}

@end
