//
//  AppDelegate.m
//  FlickrProject
//
//  Created by Александр Плесовских on 17/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//


#import "AppDelegate.h"
#import "FlickrViewController.h"
#import "FlickrPresenter.h"
#import <UserNotifications/UserNotifications.h>


@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	//Локальные пуш-уведомления
	[self prepareForNotifications];
	
	//Сборка архитектуры, создаем View, Presenter, NavigationController, Window и собираем
	FlickrViewController *flickrViewController = [FlickrViewController new];
	FlickrPresenter *presenter = [[FlickrPresenter alloc] init];
	
	flickrViewController.presenter = presenter;
	presenter.flickrView = flickrViewController;
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:flickrViewController];
	
	self.window = [UIWindow new];
	[self.window setRootViewController:navController];
	[self.window makeKeyAndVisible];
	
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma LocalNotifications

- (void) prepareForNotifications
{
	// Получаем текущий notificationCenter
	UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
	
	// Устанавливаем делегат
	center.delegate = self;
	
	// Указываем тип пушей для работы
	UNAuthorizationOptions options = UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge;
	
	// Запрашиваем доступ на работу с пушами
	[center requestAuthorizationWithOptions:options
						  completionHandler:^(BOOL granted, NSError * _Nullable error) {
							  if (!granted)
							  {
								  NSLog(@"Доступ не дали");
							  }
						  }];
}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
	   willPresentNotification:(UNNotification *)notification
		 withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
	if (completionHandler)
	{
		completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
	}
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
		 withCompletionHandler:(void(^)(void))completionHandler
{
	UNNotificationContent *content = response.notification.request.content;
	
	if (content.userInfo[@"searchRequest"])
	{
		UINavigationController *navigationController = self.window.rootViewController;
		//Возвращаемся назад, если мы не на контроллере поиска
		[navigationController popToRootViewControllerAnimated:YES];
		FlickrViewController *flickrController = [navigationController topViewController];
		[flickrController searchImagesWithText:content.userInfo[@"searchRequest"]];
	}
	
	if (completionHandler)
	{
		completionHandler();
	}
}


@end
