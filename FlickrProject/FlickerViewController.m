//
//  FlickerViewController.m
//  NSUrlRequestProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "FlickerViewController.h"
#import "CustomCollectionViewLayout.h"
#import "ImageCollectionViewCell.h"
#import "ImageViewController.h"


@interface FlickerViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar; /**< Строка поиска */
@property (nonatomic, strong) UICollectionView *collectionView; /**< Коллекшн вью для картинок */

@property (nonatomic, strong) NSMutableArray<UIImage *> *imagesArray; /**< Массив данных картинок */

@end

@implementation FlickerViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	//Подговим UI
	[self prepareUI];
	//Подготовим массив
	self.imagesArray = [NSMutableArray new];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self setTitle:@"Поиск картинок"];
	
	[self.collectionView reloadData];
}

- (void) prepareUI
{
	self.view.backgroundColor = UIColor.whiteColor;
	//Отступ сверху для навигейшн бара
	CGFloat topInset = CGRectGetMaxY(self.navigationController.navigationBar.frame);
	CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;
	CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
	
	//Инициализация серч бара
	CGFloat searchBarHeight = 50;
	self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, topInset, screenWidth, searchBarHeight)];
	[self.searchBar setPlaceholder:@"Введите запрос"];
	self.searchBar.delegate = self;
	[self.view addSubview:self.searchBar];
	
	//Инициализация коллекшн вью
	CustomCollectionViewLayout *layout = [[CustomCollectionViewLayout alloc] initWithWidth:screenWidth];
	self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), screenWidth, screenHeight - CGRectGetMaxY(self.searchBar.frame)) collectionViewLayout:layout];
	
	self.collectionView.backgroundColor = UIColor.whiteColor;
	[self.collectionView registerClass:ImageCollectionViewCell.class forCellWithReuseIdentifier:ImageCollectionViewCell.description];
	self.collectionView.dataSource = self;
	self.collectionView.delegate = self;
	[self.view addSubview:self.collectionView];
}


#pragma UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.imagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCollectionViewCell.description forIndexPath:indexPath];
	
	if (indexPath.item < self.imagesArray.count && self.imagesArray[indexPath.item] != nil)
	{
		[cell setImage:self.imagesArray[indexPath.item]];
	}
	
	return cell;
}


#pragma UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	//Открывать новый контроллер
	ImageViewController *imageViewController = [ImageViewController new];
	[imageViewController setImage:self.imagesArray[indexPath.item]];
	[self.navigationController pushViewController:imageViewController animated:true];
}


#pragma UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	//скрыть клавиатуру
	[searchBar resignFirstResponder];
	//Вызвать поиск
	[self.presenter searchActionStartWithSearchText:searchBar.text];
}


#pragma FlickerViewProtocol

/**
 Задает размер массива с изображениями и количество ячеек в коллекшн вью
 
 @param count размер массива
 */
- (void)setImageArrayCount:(NSInteger)count
{
	while (self.imagesArray.count < count)
	{
		[self.imagesArray addObject:[UIImage new]];
	}
}

/**
 Устанавливает картинку в массив
 
 @param imageData Данные изображения
 @param number Индекс в массиве
 */
- (void)setImageWithData:(NSData*)imageData atNumber:(NSInteger)number
{
	UIImage *image = [UIImage imageWithData:imageData];
	
	//Проверка, что изображение успешно получено
	if (!image) { return; }
	
	[self.imagesArray setObject:[UIImage imageWithData:imageData] atIndexedSubscript:number];
	[self.collectionView reloadData];
}

/**
 Показывает алерт с заголовком и сообщением и действием ОК
 
 @param title Заголовок сообщения
 @param message Текст сообщения
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ок" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[alertController dismissViewControllerAnimated:true completion:nil];
	}];
	
	[alertController addAction:alertAction];
	
	[self presentViewController:alertController animated:true completion:nil];
}

@end
