//
//  FlickrPresenterProtocol.h
//  FlickrProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


@protocol FlickrPresenterProtocol <NSObject>

/**
 Нажата кнопка поиска

 @param searchText текст поиска
 */
- (void)searchActionStartWithSearchText:(NSString*)searchText;

@end
