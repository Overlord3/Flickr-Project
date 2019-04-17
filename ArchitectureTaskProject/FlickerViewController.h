//
//  FlickerViewController.h
//  NSUrlRequestProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FlickerViewProtocol.h"
#import "FlickerPresenterProtocol.h"


NS_ASSUME_NONNULL_BEGIN


@interface FlickerViewController : UIViewController<FlickerViewProtocol>

@property (nonatomic,strong) id<FlickerPresenterProtocol> presenter; /**< Презентер для архитектуры MVP */

@end

NS_ASSUME_NONNULL_END
