//
//  CityForecast+CoreDataProperties.h
//  
//
//  Created by Aleksandr Martynov on 5/23/17.
//
//

#import "CityForecast+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CityForecast (CoreDataProperties)

+ (NSFetchRequest<CityForecast *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *city;
@property (nonatomic) int16_t humidity;
@property (nonatomic) int16_t pressure;
@property (nonatomic) int64_t unique;
@property (nonatomic) float temp;
@property (nullable, nonatomic, copy) NSDate *date;

@end

NS_ASSUME_NONNULL_END
