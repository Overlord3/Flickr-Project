//
//  ImageCollectionViewCell.m
//  NSUrlRequestProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "ImageCollectionViewCell.h"


@interface ImageCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView; /**< Изображение */

@end


@implementation ImageCollectionViewCell

/**
 Инициализация объекта
 
 @param frame Фрейм для ячейки
 @return Обьект ячейки
 */
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.imageView = [UIImageView new];
		self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
		//self.imageView = [[UIImageView alloc] initWithFrame:frame];
		self.imageView.backgroundColor = UIColor.blueColor;
		
		[self addSubview:self.imageView];
	}
	return self;
}

/**
 Установка изображения

 @param image Изображение
 */
- (void) setImage:(UIImage*)image
{
	if (self.imageView != nil)
	{
		self.imageView.image = image;
	}
}

@end
