//
//  CollectionViewDelegate.m
//  FlickrProject
//
//  Created by Александр Плесовских on 20/04/2019.
//  Copyright © 2019 Alexey Levanov. All rights reserved.
//


#import "CollectionViewDelegate.h"
#import "ImageViewController.h"
#import "ImageCollectionViewCell.h"


@implementation CollectionViewDelegate

+ (instancetype) initWithArray:(NSMutableArray<UIImage *> *)array navigationController:(UINavigationController *)navigationController
{
	CollectionViewDelegate *delegate = [CollectionViewDelegate new];
	delegate.imagesArray = array;
	delegate.navigationController = navigationController;
	return delegate;
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

@end
