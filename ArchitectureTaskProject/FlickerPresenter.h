//
//  FlickerPresenter.h
//  NSUrlRequestProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FlickerPresenterProtocol.h"
#import "FlickerViewProtocol.h"
#import "NetworkService.h"


NS_ASSUME_NONNULL_BEGIN


@interface FlickerPresenter : NSObject<FlickerPresenterProtocol, NetworkServiceOutputProtocol>

@property (nonatomic, weak) id<FlickerViewProtocol> flickerView; /**< Вью для архитектуры MVP */

@end

NS_ASSUME_NONNULL_END
