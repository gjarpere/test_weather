//
//  CityPickerDataSource.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "CityPickerDataSource.h"
#import "CityTableViewCell.h"

@interface CityPickerDataSource ()


@end

@implementation CityPickerDataSource


-(instancetype)init {
    self = [super init];
    
    if (self) {
        self.citiesArray = @[kLviv, kVinnytsya];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.citiesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CityTableViewCell reuseIdentifier] forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(CityTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell prepareCellWithName:self.citiesArray[indexPath.row]];
}

@end
