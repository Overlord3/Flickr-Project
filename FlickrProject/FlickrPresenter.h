//
//  FlickrPresenter.h
//  FlickrProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FlickrPresenterProtocol.h"
#import "FlickrViewProtocol.h"
#import "NetworkService.h"


NS_ASSUME_NONNULL_BEGIN


@interface FlickrPresenter : NSObject<FlickrPresenterProtocol, NetworkServiceOutputProtocol>

@property (nonatomic, weak) id<FlickrViewProtocol> flickrView; /**< Вью для архитектуры MVP */
@property (nonatomic, strong) NetworkService* networkService; /**< Сервис для архитектуры MVP */

@end

NS_ASSUME_NONNULL_END
