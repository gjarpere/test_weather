//
//  ForecastTableViewCell.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "ForecastTableViewCell.h"
#import "DateHelper.h"

@interface ForecastTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;

@end

@implementation ForecastTableViewCell

- (void)prepareCellWithForecast:(CityForecast *)forecast
{
    self.tempLabel.text = [NSString stringWithFormat:@"%.1f C", forecast.temp];
    self.pressureLabel.text = [NSString stringWithFormat:@"%d hPa", forecast.pressure];
    self.humidLabel.text = [NSString stringWithFormat:@"%d %%", forecast.humidity];
    self.dateLabel.text = [DateHelper verboseLocalDateString:forecast.date];
}

@end
