//
//  ImageViewController.h
//  FlickrProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FilterService.h"


NS_ASSUME_NONNULL_BEGIN


@interface ImageViewController : UIViewController

/**
 Инициализатор с изображением

 @param image Изображение
 @return Обьект вью контроллера
 */
+ (instancetype)initViewControllerWithImage:(UIImage *)image;

@property (nonatomic,strong) FilterService *filterService; /**< Сервис фильтров */

@end

NS_ASSUME_NONNULL_END
