//
//  CityTableViewCell.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "CityTableViewCell.h"

@interface CityTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;

@end

@implementation CityTableViewCell

- (void)prepareCellWithName:(NSString *)cityName
{
    self.cityNameLabel.text = cityName;
}


@end
