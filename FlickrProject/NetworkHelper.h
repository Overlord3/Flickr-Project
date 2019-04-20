//
//  NetworkHelper.h
//  FlickrProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface NetworkHelper : NSObject

/**
 Получение URL с запросом к сервису с текстом поиска

 @param searchString текст поиска
 @return URL в строке
 */
+ (NSString *)URLForSearchString:(NSString *)searchString;

@end
