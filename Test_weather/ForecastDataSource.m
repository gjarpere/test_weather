//
//  ForecastDataSource.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "ForecastDataSource.h"
#import <CoreData/CoreData.h>
#import "PersistenceController.h"
#import "CityForecast+CoreDataClass.h"
#import "AppDelegate.h"
#import "ForecastTableViewCell.h"

@interface ForecastDataSource () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSManagedObjectContext *uiContext;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end


@implementation ForecastDataSource

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _uiContext = [PersistenceController applicationPersistenceController].interfaceManagedObjectContext;
        [self prepareFetchedResultsController];
         [self startListeningForNotifications];
    }
    
    return self;
}

- (void)prepareFetchedResultsController
{
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"TSEProgramTableViewDataSource: error while fetching results: %@", error);
    }
}

- (void)cityUpdated
{
    [self prepareFetchedResultsController];
    [_fetchedResultsController performFetch:nil];
    [_tableView reloadData];

}

- (void)startListeningForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityUpdated) name:kCitySelectedNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:kCityForecastEntity inManagedObjectContext:_uiContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:kDate ascending:YES];
    NSString *currentCityName = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@",kCity, currentCityName];
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"%K >= %@ ", kDate, [NSDate date]];
    NSPredicate *compoundPredicate
    = [NSCompoundPredicate andPredicateWithSubpredicates:@[datePredicate, predicate]];

    [fetchRequest setPredicate:compoundPredicate];

    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:_uiContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma mark -- Table View Delegate/Data Source --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ForecastTableViewCell reuseIdentifier] forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(ForecastTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    CityForecast *forecast = [_fetchedResultsController objectAtIndexPath:indexPath];
    [cell prepareCellWithForecast:forecast];
}

#pragma mark -- Fetch Controller Delegate --

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

@end
