//
//  SomeService.h
//  ProtocolsTest
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NetworkServiceProtocol.h"


@interface NetworkService : NSObject<NetworkServiceInputProtocol, NSURLSessionDelegate>

/**
 Инициализатор сервиса

 @param params Параметры URLSession, можно nil
 @return Объект NetworkService
 */
+ (instancetype)initWithUrlConfiguration:(NSDictionary *)params;

@property (nonatomic, weak) id<NetworkServiceOutputProtocol> outputDelegate; /**< Делегат внешних событий */

@end
