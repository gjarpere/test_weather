//
//  ApiManager.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "ApiManager.h"

@implementation ApiManager

- (void)getForecastForCity:(NSString *)city completion:(CallCompletionWhithResponse)completion
{
    NSString *urlString = [NSString stringWithFormat:@"%@?%@=%@,%@&%@=%@&%@=%@", kForecastURL,kQuery, city, kCountryCode, kAppIdParameter, kAppId, kUnits, kMetric];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:URL].mutableCopy;
    [request setHTTPMethod:@"GET"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
    config.URLCache = nil;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (!data) {
                                          completion(NO, error, nil);
                                      } else {
                                          NSError *serialError = nil;
                                          
                                          NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&serialError];
                                          if (jsonDict) {
                                              completion(YES, nil, jsonDict);
                                          } else {
                                              completion(NO, serialError, nil);
                                          }
                                      }
                                  }];
    [task resume];
}


@end
