//
//  PersistenceController.h
//  Test_weather
//
//  Created by Aleksandr Martynov on 5/23/17.
//  Copyright © 2017 Aleksandr Martynov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef void (^InitCompletionBlock)(void);

@interface PersistenceController : NSObject

@property (strong, readonly) NSManagedObjectContext *interfaceManagedObjectContext;

+ (PersistenceController *)applicationPersistenceController;

- (instancetype) initWhithStoreType:(NSString *)storeType;

- (void)initializeCoreDataWithComplitionBlock:(InitCompletionBlock)completion;

- (void)save;

@end
