//
//  WeatherTableViewCell.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "WeatherTableViewCell.h"

@implementation WeatherTableViewCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
