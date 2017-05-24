//
//  CityPickerViewController.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "CityPickerViewController.h"
#import "CityTableViewCell.h"
#import "CityPickerDataSource.h"
#import "ForecastManager.h"

@interface CityPickerViewController () <UIGestureRecognizerDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *cancelRecognizer;
@property CityPickerDataSource *tableViewDataSource;

@end

@implementation CityPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupTableView];
}

- (void)setupView {
    self.cancelRecognizer.delegate = self;
    [self.cancelRecognizer addTarget:self action:@selector(dismiss)];
}

- (void)setupTableView { 
    [self.tableView registerNib:[UINib nibWithNibName:[CityTableViewCell reuseIdentifier] bundle:[NSBundle bundleForClass:[self class]]] forCellReuseIdentifier:[CityTableViewCell reuseIdentifier]];
    self.tableViewDataSource = [CityPickerDataSource new];
    self.tableViewDataSource.tableView = self.tableView;
    self.tableView.dataSource  = self.tableViewDataSource;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadForecastForSelectedCity:(NSString *)cityName {
    [[ForecastManager applicationForecastManager] loadForecastsForCity:cityName complition:^(BOOL status, NSError *error) {
        if (!status) {
            NSLog(@"Error while loading forecast: %@", error); // nslog cannot be used in production
        }
    }];
}

#pragma mark - Gesture Recognizer Delegate -

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (CGRectContainsPoint(self.tableView.bounds, [touch locationInView:self.tableView])) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Table View Delegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedCity = self.tableViewDataSource.citiesArray[indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject: selectedCity forKey:kCurrentCity]; // for what userdefaults ????
    [self loadForecastForSelectedCity:selectedCity];
    [[NSNotificationCenter defaultCenter]postNotificationName:kCitySelectedNotification object:nil];
    [self dismiss];
}

@end
