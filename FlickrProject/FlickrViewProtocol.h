//
//  FlickrViewProtocol.h
//  NSUrlRequestProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


@protocol FlickrViewProtocol <NSObject>

/**
 Задает размер массива с изображениями и количество ячеек в коллекшн вью

 @param count размер массива
 */
- (void)setImageArrayCount:(NSInteger)count;

/**
 Устанавливает картинку в массив

 @param imageData Данные изображения
 @param number Индекс в массиве
 */
- (void)setImageWithData:(NSData*)imageData atNumber:(NSInteger)number;

/**
 Показывает алерт с заголовком и сообщением и действием ОК

 @param title Заголовок сообщения
 @param message Текст сообщения
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
