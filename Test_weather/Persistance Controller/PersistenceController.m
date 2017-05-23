//
//  PersistenceController.m
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import "PersistenceController.h"
#import "AppDelegate.h"



#import "PersistenceController.h"


@interface PersistenceController ()

@property (strong) NSPersistentContainer *container;
@property (strong, readwrite) NSManagedObjectContext *interfaceManagedObjectContext;
@property (strong)  NSManagedObjectContext *privateContext;
@property (strong) NSString *storeType;

@end

@implementation PersistenceController

+ (PersistenceController *)applicationPersistenceController
{
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] persistenceController];
}

- (instancetype) initWhithStoreType:(NSString *)storeType
{
    self = [super init];
    
    if (self) {
        [self setStoreType:storeType];
    }
    
    return self;
}

- (void)initializeCoreDataWithComplitionBlock:(InitCompletionBlock)completion
{
    if (TSEiOSVersion < 10) {
        if ([self interfaceManagedObjectContext]) {
            return;
        }
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Test_weather" withExtension:@"momd"];//?)))
        NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
        [self setInterfaceManagedObjectContext:[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType]];
        [self setPrivateContext:[[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType]];
        
        [[self privateContext] setPersistentStoreCoordinator:coordinator];
        [[self interfaceManagedObjectContext] setParentContext:[self privateContext]];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSPersistentStoreCoordinator *psc = [[self privateContext] persistentStoreCoordinator];
            NSMutableDictionary *options = [NSMutableDictionary dictionary];
            options[NSMigratePersistentStoresAutomaticallyOption] = @YES;
            options[NSInferMappingModelAutomaticallyOption] = @YES;
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
            NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"DataModel.sqlite"];
            
            NSError *error = nil;
            [psc addPersistentStoreWithType:self.storeType
                              configuration:nil
                                        URL:storeURL
                                    options:options
                                      error:&error];
            if (error) {
                NSLog(@"ENPersistenceController: error while adding persistantController: %@", error);
            }
            completion(); // if comletion block nil?
        });
    } else {
        NSPersistentContainer *container = [NSPersistentContainer persistentContainerWithName:@"Test_weather"];
        container.persistentStoreDescriptions.firstObject.type = self.storeType;
        self.container = container;
        [container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
            if (error) {
                NSLog(@"ENPersistenceController: error while loading persistantStores: %@", error);
            }
        }];
        [self setInterfaceManagedObjectContext:container.viewContext];
        [self setPrivateContext:container.newBackgroundContext];
        completion();
    }
}

- (void)save
{
    if (![[self privateContext] hasChanges] && ![[self interfaceManagedObjectContext] hasChanges]) {
        return;
    }
    [[self interfaceManagedObjectContext] performBlockAndWait:^{
        NSError *error = nil;
        if ([[self interfaceManagedObjectContext] save:&error]) {
            [[self privateContext] performBlock:^{
                NSError *error = nil;
                if (![[self privateContext] save:&error]) {
                    NSLog(@"ENPersistenceController: error while saving privateContext: %@", error);
                }
            }];
        } else {
            NSLog(@"ENPersistenceController: error while saving interfaceManagedObjectContext: %@", error);
            
        }
    }];
}

@end
