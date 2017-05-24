//
//  ApiOperation.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "ApiOperation.h"

@interface ApiOperation ()

/* KVO */
@property(assign) BOOL isExecuting;
@property(assign) BOOL isFinished;

@end

@implementation ApiOperation

- (instancetype)initWithAPIManager:(ApiManager *)apiManager context:(NSManagedObjectContext *)context {
    if (self = [super init]) {
        _apiManager = apiManager;
        _workingContext = context;
    }
    
    return self;
}

#pragma mark - Events

- (void)didStartOperation {
    [self setupLoadingState];
}

- (void)didFinishOperation {
    [self setupFinishedState];
}

- (void)didFailOperationWithError:(NSError *)error {
    self.error = error;
    [self setupFinishedState];
}

- (void)didCancelOperation {
    [self setupFinishedState];
}

#pragma mark - Operation States

- (void)setupLoadingState {
    [self setIsExecuting:YES];
    [self setIsFinished:NO];
}

- (void)setupFinishedState {
    [self setIsExecuting:NO];
    [self setIsFinished:YES];
}

#pragma mark - Setup

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    return YES;
}

- (BOOL)isAsynchronous {
    return YES;
}

- (void)cancel {
    [self didCancelOperation];
    [super cancel];
}

- (void)start {
    if (self.isCancelled) {
        return;
    }
    
    [self didStartOperation];
}

@end
