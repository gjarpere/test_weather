//
//  CityPickerDataSource.h
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CityPickerDataSource : NSObject <UITableViewDataSource>

@property (nonatomic) NSArray *citiesArray;

@property (nonatomic, weak) UITableView *tableView;

@end
