//
//  ForecastManager.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "ForecastManager.h"

@interface ForecastManager ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (strong, nonatomic) PersistenceController *persistenceController;

@end

@implementation ForecastManager

- (instancetype)initWithPersistanceController:(PersistenceController *)controller
{
    if (self = [super init]) {
        _persistenceController = controller;
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    
    return self;
}

- (void)loadForecastsForCity:(NSString *)city complition:(CallCompletion)completion
{
    GetForecastOperation *operation = [[GetForecastOperation alloc] initWithAPIManager:[ApiManager new]
                                                                                     context:self.persistenceController.interfaceManagedObjectContext];
    operation.city = city;
    WEAK_SELF weakSelf = self;
    operation.completion = ^(BOOL status, NSError *error) {
        [weakSelf.persistenceController save];
        completion(status, error);
    };
    [_operationQueue addOperation:operation];
}


@end
