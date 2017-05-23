//
//  ForecastManager.h
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiManager.h"
#import "PersistenceController.h"
#import "GetForecastOperation.h"

@interface ForecastManager : NSObject

- (instancetype)initWithPersistanceController:(PersistenceController *)controller;
- (void)loadForecastsForCity:(NSString *)city complition:(CallCompletion)completion;

@end
