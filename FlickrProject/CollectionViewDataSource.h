//
//  CollectionViewDataSource.h
//  FlickrProject
//
//  Created by Александр Плесовских on 20/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface CollectionViewDataSource : NSObject<UICollectionViewDataSource>

+ (instancetype) initWithArray:(NSMutableArray<UIImage *> *)array;

@property (nonatomic, weak) NSMutableArray<UIImage *> *imagesArray; /**< Массив данных картинок */

@end

NS_ASSUME_NONNULL_END
