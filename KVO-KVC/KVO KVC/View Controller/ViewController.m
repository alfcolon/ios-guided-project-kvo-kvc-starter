//
//  ViewController.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIDepartment.h"
#import "LSIEmployee.h"
#import "LSIHRController.h"
#import "LSIInternalRevenueService.h"

@interface ViewController ()

@property (nonatomic) LSIHRController *hrController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    LSIDepartment *marketing = [[LSIDepartment alloc] init];
    marketing.name = @"Marketing";
    LSIEmployee * philSchiller = [[LSIEmployee alloc] init];
    philSchiller.name = @"Phil";
    philSchiller.jobTitle = @"VP of Marketing";
    philSchiller.salary = 10000000; 
    marketing.manager = philSchiller;

    
    LSIDepartment *engineering = [[LSIDepartment alloc] init];
    engineering.name = @"Engineering";
    LSIEmployee *craig = [[LSIEmployee alloc] init];
    craig.name = @"Craig";
    craig.salary = 9000000;
    craig.jobTitle = @"Head of Software";
    engineering.manager = craig;
    
    LSIEmployee *e1 = [[LSIEmployee alloc] init];
    e1.name = @"Chad";
    e1.jobTitle = @"Engineer";
    e1.salary = 200000;
    
    LSIEmployee *e2 = [[LSIEmployee alloc] init];
    e2.name = @"Lance";
    e2.jobTitle = @"Engineer";
    e2.salary = 250000;
    
    LSIEmployee *e3 = [[LSIEmployee alloc] init];
    e3.name = @"Joe";
    e3.jobTitle = @"Marketing Designer";
    e3.salary = 100000;
    
    [engineering addEmployee:e1];
    [engineering addEmployee:e2];
    [marketing addEmployee:e3];

    LSIHRController *controller = [[LSIHRController alloc] init];
    [controller addDepartment:engineering];
    [controller addDepartment:marketing];
    self.hrController = controller;
    
    NSLog(@"%@", self.hrController);
    
    NSLog(@"%@", self.hrController.departments);
    
    /*
     KVC - Key Value Coding - Allows us to access values (both get and set them) using the name of the property.
     
     Requirements:
     1. setter must be of form "setPropertyName"
     2. getter must be of form "propertyName"
     
     (If you haven't manually changed the anmes of the getter and setter of a property, it will be ready to for for KVC)
     
     If thingas are not named following the naming convention correctly, your app will crash at run-time. There are no compile time checks to see if the properties exist or not. It's a super dynamic feature.
     
     */
    
    // To get a value, we use the method 'valueForKey':
    
    // To set a value, we use the method 'setValue:forKey:'
    
    // We can even get and set private properties using KVC. Obviously this doesn't mean we SHOULD do it. If it was made private, there is pribably a good reason.
    
    NSLog(@"%@", [self.hrController valueForKeyPath:@"departments"]);
    
    NSLog(@"%@", [craig valueForKeyPath:@"secret"]);
    
    // A makeshift filter
    NSInteger highestSalary = [[marketing valueForKeyPath:@"employees.@max.salary"] integerValue];
    NSLog(@"%li", highestSalary);
    
    NSLog(@"%@", [self.hrController allEmployees]);
    
    /*
     // KVO - Key Value Observinf (Hook for logic or UI updates)
     
     KVO lets us listen to any changes to a value, then do something in resoinse to that change.
     
     This is somewhat similar to us listening (observing) to a notification using 'NotificationCenter':
     
     - If we care to know when a value changes, we need to add an observer.
     - We don't however need to "post" or trigger the notification from happening like we do with
     Notification Center. As soon as the value changes, the notification is sent out to observers automatically.
     
     */
    
    [[LSIInternalRevenueService sharedService] startMonitoringEmployee:philSchiller];
    
    philSchiller.salary = 20000000;
    
}


@end
