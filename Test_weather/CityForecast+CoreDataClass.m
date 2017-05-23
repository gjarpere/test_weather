//
//  CityForecast+CoreDataClass.m
//  
//
//  Created by Aleksandr Martynov on 5/23/17.
//
//

#import "CityForecast+CoreDataClass.h"

@implementation CityForecast

+ (EKManagedObjectMapping *)objectMapping {
    EKManagedObjectMapping *mapping = [EKManagedObjectMapping mappingForEntityName:NSStringFromClass([self class])
                                                                         withBlock:^(EKManagedObjectMapping *mapping) {
                                                                             mapping.ignoreMissingFields = YES;
                                                                             
                                                                             [mapping mapKeyPath:kCityName toProperty:kCity];
                                                                             [mapping mapKeyPath:kTemperaturePath toProperty:kTemperature];
                                                                             [mapping mapKeyPath:kHumidityPath toProperty:kHumidity];
                                                                             [mapping mapKeyPath:kPressurePath toProperty:kPressure];
                                                                         }];
    mapping.primaryKey = kCity;
    
    return mapping;
}

@end
