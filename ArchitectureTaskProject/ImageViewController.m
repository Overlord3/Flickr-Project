//
//  ImageViewController.m
//  NSUrlRequestProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "ImageViewController.h"


@interface ImageViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation ImageViewController

- (instancetype)init
{
	self = [super init];
	if (self)
	{
		self.imageView = [UIImageView new];
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self prepareUI];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.title = @"Изображение";
}

- (void) prepareUI
{
	self.view.backgroundColor = UIColor.whiteColor;
	
	CGFloat width = UIScreen.mainScreen.bounds.size.width;
	
	self.imageView.backgroundColor = UIColor.blueColor;
	self.imageView.frame = CGRectMake(0, 0, width, width);
	self.imageView.center = self.view.center;
	
	[self.view addSubview:self.imageView];
}

/**
 Установка изображения для вью контроллера
 
 @param image Изображение
 */
- (void)setImage:(UIImage *)image
{
	[self.imageView setImage:image];
}

@end
