//
//  ApiManager.h
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiManager : NSObject

typedef void (^CallCompletion)(BOOL status, NSError *);
typedef void (^CallCompletionWhithResponse)(BOOL status, NSError *error, NSDictionary *response);

- (void)getForecastForCity:(NSString *)city completion:(CallCompletionWhithResponse)completion;


@end
