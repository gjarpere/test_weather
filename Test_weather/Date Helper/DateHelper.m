//
//  DateHelper.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

+ (NSDate *)forecastDateFromString:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]]) { // its not a helper (really) just as is
        return nil;
    }
    int unixTime = string.intValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:unixTime];
    
    return date;
}

+ (NSString *)verboseLocalDateString:(NSDate *)date
{
    NSDateFormatter *dateToStringFormatter = [NSDateFormatter new];
    dateToStringFormatter.dateFormat = @"dd/M/YYYY'";// funny fot helper
    
    return [dateToStringFormatter stringFromDate:date];
}

@end
