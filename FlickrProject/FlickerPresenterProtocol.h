//
//  FlickerPresenterProtocol.h
//  NSUrlRequestProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


@protocol FlickerPresenterProtocol <NSObject>

/**
 Нажата кнопка поиска

 @param searchText текст поиска
 */
- (void)searchActionStartWithSearchText:(NSString*)searchText;

@end
