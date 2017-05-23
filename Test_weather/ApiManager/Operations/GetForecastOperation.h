//
//  GetForecastOperation.h
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "ApiOperation.h"
#import "CityForecast+CoreDataClass.h"

@interface GetForecastOperation : ApiOperation

@property (copy, nonatomic) NSString *city;

@property (copy, nonatomic) CallCompletion completion;

@end
