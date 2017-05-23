//
//  CityForecast+CoreDataClass.m
//  
//
//  Created by Aleksandr Martynov on 5/23/17.
//
//

#import "CityForecast+CoreDataClass.h"
#import "DateHelper.h"

@implementation CityForecast

+ (EKManagedObjectMapping *)objectMapping {
    EKManagedObjectMapping *mapping = [EKManagedObjectMapping mappingForEntityName:NSStringFromClass([self class])
                                                                         withBlock:^(EKManagedObjectMapping *mapping) {
                                                                             mapping.ignoreMissingFields = YES;
                                                                             [mapping mapKeyPath:kCity toProperty:kCity];
                                                                             [mapping mapKeyPath:kTemperaturePath toProperty:kTemperature];
                                                                             [mapping mapKeyPath:kHumidityPath toProperty:kHumidity];
                                                                             [mapping mapKeyPath:kPressurePath toProperty:kPressure];
                                                                             [mapping mapKeyPath:kUnique toProperty:kUnique];
                                                                             [mapping mapKeyPath:kDatePath toProperty:kDate withValueBlock:^id(NSString *key, id value, NSManagedObjectContext *context) {
                                                                                 NSDate *startDate = [DateHelper forecastDateFromString:value];
                                                                                 return startDate;
                                                                             }];

                                                                         }];
    mapping.primaryKey = kUnique;
    
    return mapping;
}


@end
