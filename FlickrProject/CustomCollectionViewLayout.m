//
//  CustomCollectionViewLayout.m
//  FlickrProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "CustomCollectionViewLayout.h"


@interface CustomCollectionViewLayout ()

@property(nonatomic, assign) CGRect contentBounds; /**< Размер коллекшн вью */

@property(nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *cache; /**< Кэш для атрибутов */

@property(nonatomic, assign, readonly) CGFloat itemHeight; /**< Высота ячейки */
@property(nonatomic, assign, readonly) CGFloat borderInset; /**< Отступы с краев */
@property(nonatomic, assign, readonly) CGFloat itemWidth; /**< Ширина ячейки */

@end


@implementation CustomCollectionViewLayout

/**
 Инициализатор лайаута
 
 @param width Ширина коллекшн вью
 @return Обьект лайаута
 */
- (instancetype)initWithWidth:(CGFloat)width
{
	self = [super init];
	if (self)
	{
		//Проинициализируем объект
		_borderInset = 16;
		_itemWidth = (width - 3*_borderInset) / 2;
		_itemHeight = _itemWidth;
		_contentBounds = CGRectMake(0, 0, 0, 0);
		_cache = [NSMutableArray new];
	}
	return self;
}

/**
 Расстановка UI элементов
 */
- (void)prepareLayout
{
	[super prepareLayout];
	
	//точно одна секция
	NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
	
	NSInteger index = 0;
	
	while (index < itemCount)
	{
		CGRect itemFrame = [self getFrameForItemWith:index];
		UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
		attributes.frame = itemFrame;
		
		[self.cache addObject:attributes];
		self.contentBounds = CGRectUnion(self.contentBounds, itemFrame);
		
		index += 1;
	}
}

/**
 Возвращает размеры

 @return Размеры коллекшн вью
 */
- (CGSize)collectionViewContentSize
{
	return self.contentBounds.size;
}

/**
 Атрибуты ячейки по индексу

 @param indexPath индекс ячейки
 @return Обьект атрибутов из кеша
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return self.cache[indexPath.item];
}

/**
 Основная функция, возвращает фрейм для ячейки

 @param number Индекс ячейки
 @return Фрейм
 */
- (CGRect) getFrameForItemWith: (NSInteger)number
{
	CGRect frame;
	//Проверим какой это элемент
	if (number % 2 == 0)
	{
		//Это элемент слева
		CGFloat yOffset = self.borderInset + (number/2)*(self.borderInset + self.itemHeight);
		frame = CGRectMake(self.borderInset, yOffset, self.itemWidth, self.itemHeight);
	}
	else
	{
		//Это элемент справа
		CGFloat yOffset = self.borderInset + (number/2)*(self.borderInset + self.itemHeight);
		frame = CGRectMake(self.borderInset*2 + self.itemWidth, yOffset, self.itemWidth, self.itemHeight);
	}
	return frame;
}

/**
 Размеры для группы ячеек на экране

 @param rect Какую область экрана запрашивают (фрейм)
 @return Массив атрибутов для видимых ячеек
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
	NSMutableArray<UICollectionViewLayoutAttributes *> *visibleAttributes = [NSMutableArray new];
	
	for (UICollectionViewLayoutAttributes *object in self.cache)
	{
		//Используем пересечение, чтобы найти все атрибуты
		if (CGRectIntersectsRect(object.frame, rect))
		{
			[visibleAttributes addObject:object];
		}
	}
	return visibleAttributes;
}

@end
