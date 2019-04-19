//
//  FlickrViewController.h
//  NSUrlRequestProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FlickrViewProtocol.h"
#import "FlickrPresenterProtocol.h"


NS_ASSUME_NONNULL_BEGIN


@interface FlickrViewController : UIViewController<FlickrViewProtocol>

@property (nonatomic,strong) id<FlickrPresenterProtocol> presenter; /**< Презентер для архитектуры MVP */

@end

NS_ASSUME_NONNULL_END
