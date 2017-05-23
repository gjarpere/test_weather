//
//  AppDelegate.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/22/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, readwrite) PersistenceController *persistenceController;
@property (nonatomic, readwrite) ForecastManager *forecastManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.persistenceController = [[PersistenceController alloc] initWhithStoreType:NSSQLiteStoreType];
    WEAK_SELF weakSelf = self;
    [self.persistenceController initializeCoreDataWithComplitionBlock:^{
        STRONG_SELF strongSelf = weakSelf;
        strongSelf.forecastManager = [[ForecastManager alloc] initWithPersistanceController:strongSelf.persistenceController];
        [strongSelf.forecastManager loadForecastsForCity:kLviv
                                              complition:^(BOOL status, NSError *error) {
            if (!status) {
                NSLog(@"Error while loading programs: %@", error);
            }
        }];

    }];
    return YES;
}

@end
