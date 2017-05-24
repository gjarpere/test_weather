//
//  GetForecastOperation.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "GetForecastOperation.h"

@interface GetForecastOperation ()

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) NSArray<CityForecast *> *mappedItems;

@end

@implementation GetForecastOperation

- (instancetype)initWithAPIManager:(ApiManager *)apiManager context:(NSManagedObjectContext *)context {
    if (self = [super initWithAPIManager:apiManager context:context]) {
        _items = [NSMutableArray array];
    }
    
    return self;
}

- (void)start {
    [super start];
    [self loadForecast];
}

#pragma mark - Loading data

- (void)loadForecast {
    WEAK_SELF weakSelf = self;
    [self.workingContext performBlock:^{
        STRONG_SELF strongSelf = weakSelf;
        [strongSelf.apiManager getForecastForCity:strongSelf.city completion:^(BOOL status, NSError *error, NSDictionary *response) {
            STRONG_SELF strongSelf = weakSelf;
            if (status) {
                strongSelf.items = response[kList];
                NSString *city = [response valueForKeyPath:kCityNamePath];
                NSNumber *cityCode = [response valueForKeyPath:kCityCodePath];
                [strongSelf prepareInitialArrayForCity:city cityCode:cityCode];
                [strongSelf mapItems];
            } else {
                strongSelf.error = error;
                [strongSelf didFailOperationWithError:error];
            }
        }];
    }];
}

- (void)prepareInitialArrayForCity:(NSString *)city cityCode:(NSNumber *)cityCode {
    NSMutableArray *resultArray =@[].mutableCopy;
    for (int i = 0; i < self.items.count; i++)
    {
        NSMutableDictionary *resultItem = ((NSDictionary *)self.items[i]).mutableCopy;
        NSString *str = [NSString stringWithFormat:@"%@%@",cityCode, resultItem[kDatePath]];
        NSNumber *primaryKey = [NSNumber numberWithUnsignedInteger:[str integerValue]];
        [resultItem setObject:primaryKey forKey:kUnique];
        [resultItem setObject:city forKey:kCity];
        [resultArray addObject:resultItem];
    }
    
    self.items = resultArray;
}


- (void)mapItems {
    
    self.mappedItems = (NSArray<CityForecast *> *)[EKManagedObjectMapper arrayOfObjectsFromExternalRepresentation:self.items
                                                                                                      withMapping:[CityForecast objectMapping]
                                                                                                                    inManagedObjectContext:self.workingContext];
    if (self.isCancelled) {
        return;
    }
    NSError *saveError = nil;
    if (![self.workingContext save:(&saveError)]) {
        [self didFailOperationWithError:saveError];
    } else {
        [self didFinishOperation];
    }
}

#pragma mark - Overrides

- (void)didFinishOperation {
    SAFE_BLOCK(self.completion, YES, self.error);
    [super didFinishOperation];
}

- (void)didFailOperationWithError:(NSError *)error {
    SAFE_BLOCK(self.completion, NO, error);
    [super didFailOperationWithError:error];
}

- (void)didCancelOperation {
    NSError *cancelError = [NSError errorWithDomain:@"" code:0 userInfo:nil];
    SAFE_BLOCK(self.completion, NO, cancelError);
    [super didCancelOperation];
}

@end
