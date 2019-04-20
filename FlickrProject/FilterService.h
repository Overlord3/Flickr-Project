//
//  FilterService.h
//  FlickrProject
//
//  Created by Александр Плесовских on 20/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface FilterService : NSObject

/**
 Сепия фильтр для изображения
 
 @param image Базовое изображение
 @return Измененное изображение
 */
- (UIImage *)addSepiaFilterToImage:(UIImage *)image;

/**
 Черно-белый фильтр для изображения
 
 @param image Базовое изображение
 @return Измененное изображение
 */
- (UIImage *)addMonoFilterToImage:(UIImage *)image;

/**
 Инверсия цвета фильтр для изображения
 
 @param image Базовое изображение
 @return Измененное изображение
 */
- (UIImage *)addColorInvertFilterToImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
