//
//  ForecastManager.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "ForecastManager.h"
#import "AppDelegate.h"

@interface ForecastManager ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (strong, nonatomic) PersistenceController *persistenceController;

@end

@implementation ForecastManager

+ (ForecastManager *)applicationForecastManager
{
    ForecastManager *manager = ((AppDelegate *)[UIApplication sharedApplication].delegate).forecastManager;
    return manager;
}

- (instancetype)initWithPersistanceController:(PersistenceController *)controller { // instancetype. what is it? {
    if (self = [super init]) {
        _persistenceController = controller;
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    
    return self;
}

- (void)loadForecastsForCity:(NSString *)city complition:(CallCompletion)completion {
    NSManagedObjectContext *privateMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [privateMOC setParentContext:self.persistenceController.interfaceManagedObjectContext];
    GetForecastOperation *operation = [[GetForecastOperation alloc] initWithAPIManager:[ApiManager new]
                                                                                     context:privateMOC];
    operation.city = city;
    WEAK_SELF weakSelf = self; // cool
    operation.completion = ^(BOOL status, NSError *error) {
        [weakSelf.persistenceController save];
        completion(status, error);
    };
    [_operationQueue addOperation:operation];
}

@end
