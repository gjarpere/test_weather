//
//  AppDelegate.h
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/22/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PersistenceController.h"
#import "ForecastManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, readonly) PersistenceController *persistenceController;
@property (nonatomic, readonly) ForecastManager *forecastManager;


@end

