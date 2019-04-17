//
//  ImageViewController.h
//  NSUrlRequestProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


@interface ImageViewController : UIViewController

/**
 Установка изображения для вью контроллера

 @param image Изображение
 */
- (void) setImage: (UIImage *)image;

@end

NS_ASSUME_NONNULL_END
