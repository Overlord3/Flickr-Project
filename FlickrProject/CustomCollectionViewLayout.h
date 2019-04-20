//
//  CustomCollectionViewLayout.h
//  FlickrProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface CustomCollectionViewLayout : UICollectionViewLayout

/**
 Инициализатор лайаута

 @param width Ширина коллекшн вью
 @return Обьект лайаута
 */
- (instancetype)initWithWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
