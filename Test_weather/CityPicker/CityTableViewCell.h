//
//  CityTableViewCell.h
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherTableViewCell.h"


@interface CityTableViewCell : WeatherTableViewCell

- (void)prepareCellWithName:(NSString *)cityName;

@end
