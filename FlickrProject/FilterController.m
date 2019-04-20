//
//  FilterController.m
//  FlickerProject
//
//  Created by Александр Плесовских on 20/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "FilterController.h"


@implementation FilterController


#pragma Фильтры по типам

/**
 Сепия фильтр для изображения
 
 @param image Базовое изображение
 @return Измененное изображение
 */
- (UIImage *)addSepiaFilterToImage:(UIImage *)image
{
	NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:@0.7, @"inputIntensity", nil];
	return [self addFilterForImage:image withName:@"CISepiaTone" andParams:params];
}

/**
 Черно-белый фильтр для изображения
 
 @param image Базовое изображение
 @return Измененное изображение
 */
- (UIImage *) addMonoFilterToImage:(UIImage *)image
{
	return [self addFilterForImage:image withName:@"CIPhotoEffectMono" andParams:nil];
}

/**
 Инверсия цвета фильтр для изображения
 
 @param image Базовое изображение
 @return Измененное изображение
 */
- (UIImage *) addColorInvertFilterToImage:(UIImage *)image
{
	return [self addFilterForImage:image withName:@"CIColorInvert" andParams:nil];
}


#pragma Применение фильтров

- (UIImage *) addFilterForImage:(UIImage *)image withName:(NSString *)filterName andParams:(NSDictionary *)params
{
	CIImage *ciimage = [CIImage imageWithCGImage:image.CGImage];
	CIFilter *filter = [CIFilter filterWithName:filterName];
	[filter setValue:ciimage forKey:kCIInputImageKey];
	
	for(id key in params)
	{
		[filter setValue:[params objectForKey:key] forKey:key];
		NSLog(@"key=%@ value=%@", key, [params objectForKey:key]);
	}
	
	return [UIImage imageWithCIImage:filter.outputImage];
}

@end
