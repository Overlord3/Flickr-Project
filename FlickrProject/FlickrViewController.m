//
//  FlickrViewController.m
//  FlickrProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "FlickrViewController.h"
#import "CustomCollectionViewLayout.h"
#import "ImageCollectionViewCell.h"
#import "CollectionViewDataSource.h"
#import "ImageViewController.h"


@interface FlickrViewController () <UISearchBarDelegate, UICollectionViewDelegate>

@property (nonatomic, strong) UISearchBar *searchBar; /**< Строка поиска */
@property (nonatomic, strong) UICollectionView *collectionView; /**< Коллекшн вью для картинок */

@property (nonatomic, strong) NSMutableArray<UIImage *> *imagesArray; /**< Массив данных картинок */
@property (nonatomic, strong) CollectionViewDataSource *dataSource; /**< Реализует протокол UICollectionViewDataSource */

@property (nonatomic, assign) NSInteger currentPageNumber; /**< Номер текущей страницы */
@property (nonatomic, assign) BOOL isLoading; /**< Флаг загрузки изображений, предотвращает двойную загрузку */

@property (nonatomic, strong) NSString *previousRequest; /**< Предыдущий запрос, нужен для уведомлений */

@end


@implementation FlickrViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	//Подготовим массив
	self.imagesArray = [NSMutableArray new];
	self.dataSource = [CollectionViewDataSource initWithArray:self.imagesArray];
	//Подговим UI
	[self prepareUI];
	//Подготовим сервис уведомлений
	self.notificationService = [NotificationsService new];
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
	self.collectionView.dataSource = self.dataSource;
	self.collectionView.delegate = self;
	[self.view addSubview:self.collectionView];
}


#pragma UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	//скрыть клавиатуру
	[searchBar resignFirstResponder];
	
	//Удалить все с прошлого поиска
	[self.collectionView setContentOffset:CGPointZero animated:YES];
	[self.imagesArray removeAllObjects];
	[self setArraySize:20];
	
	//Отправить уведомление
	if (self.previousRequest == nil)
	{
		self.previousRequest = searchBar.text;
	}
	else
	{
		//Сформируем
		NSString *title = [NSString stringWithFormat:@"Вы давно не искали картинки по теме - %@!", self.previousRequest];
		[self.notificationService sendLocalNotificationAfterSeconds:10 withTitle:title andSearchText: self.previousRequest];
		//Перезапишем предыдущий запрос
		self.previousRequest = searchBar.text;
	}
	//Вызвать поиск
	self.currentPageNumber = 1;
	[self.presenter searchActionStartWithSearchText:searchBar.text];
}


#pragma UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	//Открывать новый контроллер
	ImageViewController *imageViewController = [ImageViewController initViewControllerWithImage:self.imagesArray[indexPath.item]];
	[self.navigationController pushViewController:imageViewController animated:true];
}

/**
 Этот делегат здесь из-за этого метода, чтобы при прокрутке загружать следующую страницу

 @param scrollView Это CollectionView с картинками
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat offsetY = scrollView.contentOffset.y;
	CGFloat contentHeight = scrollView.contentSize.height;
	if (offsetY > contentHeight - scrollView.frame.size.height)
	{
		//Подгрузим следующую страницу
		if (!self.isLoading && ![self.searchBar.text isEqual: @""])
		{
			self.isLoading = YES;
			self.currentPageNumber += 1;
			[self.presenter loadImageWithSearchText:self.searchBar.text atPage:self.currentPageNumber];
		}
	}
}


#pragma FlickrViewProtocol

/**
 Задает размер массива с изображениями и количество ячеек в коллекшн вью
 
 @param count размер массива
 */
- (void)setImageArrayCount:(NSInteger)count
{
	[self setArraySize:count];
	self.isLoading = NO;
}

- (void)setArraySize:(NSInteger)count
{
	while (self.imagesArray.count < count)
	{
		[self.imagesArray addObject:[UIImage new]];
	}
	[self.collectionView reloadData];
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

/**
 Поиск с параметрами, используется для обработки пуш-уведомлений
 
 @param text текст для поиска
 */
- (void)searchImagesWithText:(NSString *)text
{
	[self.searchBar setText:text];
	[self searchBarSearchButtonClicked:self.searchBar];
}

@end
