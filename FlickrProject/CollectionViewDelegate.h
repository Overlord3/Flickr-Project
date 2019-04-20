//
//  CollectionViewDelegate.h
//  FlickrProject
//
//  Created by Александр Плесовских on 20/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface CollectionViewDelegate : NSObject<UICollectionViewDataSource, UICollectionViewDelegate>

+ (instancetype) initWithArray:(NSMutableArray<UIImage *> *)array navigationController:(UINavigationController *)navigationController;

@property (nonatomic, weak) NSMutableArray<UIImage *> *imagesArray; /**< Массив данных картинок */
@property (nonatomic, weak) UINavigationController *navigationController; /**< Контроллер для перехода на следующий экран */

@end

NS_ASSUME_NONNULL_END
