//
//  ImageViewController.m
//  FlickrProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "ImageViewController.h"


@interface ImageViewController ()

@property (nonatomic, strong) UIImage *baseImage; /**< Изначальное изображение */
@property (nonatomic, strong) UIImageView *imageView; /**< Показывает изображение */

@property (nonatomic, strong) UIButton *sepiaFilterButton; /**< Кнопка фильтра Сепия */
@property (nonatomic, strong) UIButton *monoFilterButton; /**< Кнопка фильтра Моно */
@property (nonatomic, strong) UIButton *colorInvertFilterButton; /**< Кнопка фильтра Инвертирование цвета */
@property (nonatomic, strong) UIButton *resetFilterButton; /**< Кнопка сброса фильтров */

@end


@implementation ImageViewController

/**
 Инициализатор с изображением
 
 @param image Изображение
 @return Обьект вью контроллера
 */
+ (instancetype)initViewControllerWithImage:(UIImage *)image
{
	ImageViewController *viewController = [ImageViewController new];
	viewController.baseImage = image;
	viewController.imageView.image = image;
	return viewController;
}

/**
 Инициализатор, создает imageView и baseImage
 @return Обьект вью контроллера
 */
- (instancetype)init
{
	self = [super init];
	if (self)
	{
		_imageView = [UIImageView new];
		_baseImage = [UIImage new];
		_filterService = [FilterService new];
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


#pragma Подготовка элементов вью

- (void) prepareUI
{
	self.view.backgroundColor = UIColor.whiteColor;
	//Отступ сверху для навигейшн бара
	CGFloat topInset = CGRectGetMaxY(self.navigationController.navigationBar.frame);
	CGFloat width = UIScreen.mainScreen.bounds.size.width;
	
	self.imageView.backgroundColor = UIColor.blueColor;
	self.imageView.frame = CGRectMake(0, topInset, width, width);
	
	[self.view addSubview:self.imageView];
	
	CGFloat buttonHeight = 35;
	CGFloat border = 10;
	CGFloat buttonWidth = width - border*2;
	CGFloat yOffset = CGRectGetMaxY(self.imageView.frame) + border;
	//Кнопка фильтра Сепия
	self.sepiaFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.sepiaFilterButton.frame = CGRectMake(border, yOffset, buttonWidth, buttonHeight);
	[self.sepiaFilterButton setBackgroundColor:UIColor.lightGrayColor];
	[self.sepiaFilterButton setTitle:@"Сепия фильтр" forState:UIControlStateNormal];
	[self.sepiaFilterButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
	[self.sepiaFilterButton addTarget:self action:@selector(sepiaFilterAction) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.sepiaFilterButton];
	
	//Кнопка фильтра черно-белый
	yOffset = CGRectGetMaxY(self.sepiaFilterButton.frame) + border;
	self.monoFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.monoFilterButton.frame = CGRectMake(border, yOffset, buttonWidth, buttonHeight);
	[self.monoFilterButton setBackgroundColor:UIColor.lightGrayColor];
	[self.monoFilterButton setTitle:@"Черно-белый фильтр" forState:UIControlStateNormal];
	[self.monoFilterButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
	[self.monoFilterButton addTarget:self action:@selector(monoFilterAction) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.monoFilterButton];
	
	//Кнопка фильтра инвертирование цвета
	yOffset = CGRectGetMaxY(self.monoFilterButton.frame) + border;
	self.colorInvertFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.colorInvertFilterButton.frame = CGRectMake(border, yOffset, buttonWidth, buttonHeight);
	[self.colorInvertFilterButton setBackgroundColor:UIColor.lightGrayColor];
	[self.colorInvertFilterButton setTitle:@"Инвертирование цвета" forState:UIControlStateNormal];
	[self.colorInvertFilterButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
	[self.colorInvertFilterButton addTarget:self action:@selector(colorInvertFilterAction) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.colorInvertFilterButton];
	
	//Кнопка сброса фильтров
	yOffset = CGRectGetMaxY(self.colorInvertFilterButton.frame) + border;
	self.resetFilterButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.resetFilterButton.frame = CGRectMake(border, yOffset, buttonWidth, buttonHeight);
	[self.resetFilterButton setBackgroundColor:UIColor.lightGrayColor];
	[self.resetFilterButton setTitle:@"Сброс фильтров" forState:UIControlStateNormal];
	[self.resetFilterButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
	[self.resetFilterButton addTarget:self action:@selector(resetFilterAction) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.resetFilterButton];
}


#pragma Обработка событий нажатия, FilterActions

/**
 При нажатии на кнопку применяет фильтр - сепия
 */
- (void) sepiaFilterAction
{
	UIImage *filteredImage = [self.filterService addSepiaFilterToImage:self.baseImage];
	self.imageView.image = filteredImage;
}

/**
 При нажатии на кнопку применяет фильтр - черно-белый
 */
- (void) monoFilterAction
{
	UIImage *filteredImage = [self.filterService addMonoFilterToImage:self.baseImage];
	self.imageView.image = filteredImage;
}

/**
 При нажатии на кнопку применяет фильтр - инвертирование цвета
 */
- (void) colorInvertFilterAction
{
	UIImage *filteredImage = [self.filterService addColorInvertFilterToImage:self.baseImage];
	self.imageView.image = filteredImage;
}

/**
 При нажатии на кнопку сбрасывает фильтры
 */
- (void) resetFilterAction
{
	self.imageView.image = self.baseImage;
}

@end
