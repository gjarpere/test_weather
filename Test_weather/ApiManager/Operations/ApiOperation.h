//
//  ApiOperation.h
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "EasyMapping.h"

#import "ApiManager.h"

@interface ApiOperation : NSOperation

typedef void (^CallCompletion)(BOOL status, NSError *);
typedef void (^CallCompletionWhithResponse)(BOOL status, NSError *error, NSDictionary *response);

@property (strong, nonatomic) NSError *error;
@property (strong, nonatomic, readonly) ApiManager *apiManager;
@property (strong, nonatomic, readonly) NSManagedObjectContext *workingContext;

- (instancetype)initWithAPIManager:(ApiManager *)apiManager context:(NSManagedObjectContext *)context;

- (void)didStartOperation;
- (void)didFinishOperation;
- (void)didFailOperationWithError:(NSError *)error;
- (void)didCancelOperation;

@end
