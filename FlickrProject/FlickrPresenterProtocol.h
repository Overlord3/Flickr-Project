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

/**
 Загружаем картинки следующей страницы, вызывается при прокрутке collectionView
 
 @param searchText текст поиска
 @param page номер страницы(с 1)
 */
- (void)loadImageWithSearchText:(NSString*)searchText atPage:(NSInteger)page;

@end
