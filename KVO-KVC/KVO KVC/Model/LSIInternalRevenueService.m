//
//  LSIInternalRevenueService.m
//  KVO KVC
//
//  Created by Alfredo Colon on 9/6/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIInternalRevenueService.h"
#import "LSIEmployee.h"

@interface LSIInternalRevenueService ()

//MARK: - Private Properties

@property (nonatomic) NSMutableArray *monitoredEmployees;

@end

@implementation LSIInternalRevenueService

+ (LSIInternalRevenueService *)sharedService
{
    // creating a singleton
    static LSIInternalRevenueService *sharedService = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedService = [[LSIInternalRevenueService alloc] init];
    });
    
    return sharedService; // Swift version: var somObject: String = {}() - a closure that just runs a single time
}

//MARK: - Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        // new calls alloc and init once
        _monitoredEmployees = [NSMutableArray new];
    }
    return self;
}

// What we want to monitor about the employee is their salary
- (void)startMonitoringEmployee:(LSIEmployee *)employee
{
    [employee addObserver: self
               forKeyPath:@"salary"
                  options:0
                  context:NULL];
    [self.monitoredEmployees addObject:employee];
}

// Responding to observed chanfes happens in the 'observeValueForKeyPath'
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"%@'s %S is now %@", object, keyPath, [object valueForKeyPath: keyPath]);
}

@end
