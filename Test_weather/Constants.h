//
//  Constants.h
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */

#pragma mark - Entities -

static NSString * const kCityForecastEntity          = @"CityForecast";

#pragma mark - Fields -

static NSString * const kCity                        = @"city";
static NSString * const kTemperature                 = @"temp";
static NSString * const kHumidity                    = @"humidity";
static NSString * const kPressure                    = @"pressure";
static NSString * const kDate                        = @"date";
static NSString * const kUnique                      = @"unique";

static NSString * const kCityNamePath                = @"city.name";
static NSString * const kCityCodePath                = @"city.id";
static NSString * const kTemperaturePath             = @"temp.day";
static NSString * const kHumidityPath                = @"humidity";
static NSString * const kPressurePath                = @"pressure";
static NSString * const kDatePath                    = @"dt";

static NSString * const kList                        = @"list";


static NSString * const kQuery                       = @"q";
static NSString * const kAppIdParameter              = @"appid";
static NSString * const kCountryCode                 = @"ua";

#pragma mark - URLs -

static NSString * const kForecastURL                 = @"http://api.openweathermap.org/data/2.5/forecast/daily";


static NSString * const kAppId                       = @"20ada788ac44ee52dc8de9a0a18e1887";

#pragma mark - Cities -

static NSString * const kLviv                        = @"Lviv";
static NSString * const kVinnytsya                   = @"Vinnytsya";

