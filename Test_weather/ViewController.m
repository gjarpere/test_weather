//
//  ViewController.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/22/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "ViewController.h"
#import "ForecastTableViewCell.h"
#import "ForecastDataSource.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cityButton;

@property ForecastDataSource *tableViewDataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startListeningForNotifications];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupTableView];
    [self updateCityButton];
}

- (void)setupTableView {
    [self.tableView registerNib:[UINib nibWithNibName:[ForecastTableViewCell reuseIdentifier] bundle:[NSBundle bundleForClass:[self class]]] forCellReuseIdentifier:[ForecastTableViewCell reuseIdentifier]];
    self.tableViewDataSource = [ForecastDataSource new];
    self.tableViewDataSource.tableView = self.tableView;
    self.tableView.dataSource  = self.tableViewDataSource;
}

- (void)startListeningForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCityButton) name:kCitySelectedNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateCityButton {
  NSString *currentCityName = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCity];
    [self.cityButton setTitle:currentCityName forState:UIControlStateNormal];
    [self.tableView reloadData];
}


@end
