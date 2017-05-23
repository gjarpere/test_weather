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

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.persistenceController = [[PersistenceController alloc] initWhithStoreType:NSSQLiteStoreType];
    [self.persistenceController initializeCoreDataWithComplitionBlock:nil];
    return YES;
}

@end
