//
//  CityForecast+CoreDataProperties.m
//  
//
//  Created by Aleksandr Martynov on 5/23/17.
//
//

#import "CityForecast+CoreDataProperties.h"

@implementation CityForecast (CoreDataProperties)

+ (NSFetchRequest<CityForecast *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CityForecast"];
}

@dynamic city;
@dynamic humidity;
@dynamic pressure;
@dynamic unique;
@dynamic temp;
@dynamic date;

@end
