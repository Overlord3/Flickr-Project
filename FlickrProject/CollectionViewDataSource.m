//
//  CollectionViewDataSource.m
//  FlickrProject
//
//  Created by Александр Плесовских on 20/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "CollectionViewDataSource.h"
#import "ImageCollectionViewCell.h"


@implementation CollectionViewDataSource

+ (instancetype) initWithArray:(NSMutableArray<UIImage *> *)array
{
	CollectionViewDataSource *dataSource = [CollectionViewDataSource new];
	dataSource.imagesArray = array;
	return dataSource;
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

@end
