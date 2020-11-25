//
//  LSIHRDepartment.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIHRController.h"
#import "LSIDepartment.h"
#import "LSIEmployee.h"

@interface LSIHRController ()

//MARK: - Private Properties

@property (nonatomic) NSMutableArray <LSIDepartment *> *internalDepartments;

@end

@implementation LSIHRController

//MARK: - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        _internalDepartments = [[NSMutableArray alloc] init];
    }
    return self;
}

//MARK: - Properties

- (NSArray<LSIEmployee *> *)allEmployees
{
    // With KVC
    NSArray *allEmployees = [self valueForKeyPath:@"departments.@unionOfArrays.employees"];
    return allEmployees;
    
    //  With loops
    //    NSMutableArray *allEmployess = @[];
    //    for (LSIDepartment *department in self.departments) {
    //        for (LSIEmployee *employee in  department.employees) {
    //            [allEmployess addObject:employee];
    //        }
    //    }
    //
    //    return allemployess;
}

- (NSArray<LSIDepartment *> *)departments {
    return [self.internalDepartments copy];
}

//MARK: - Methods

- (void)addDepartment:(LSIDepartment *)department
{
    [self.internalDepartments addObject:department];
}

- (NSString *)description {
    NSMutableString *output = [[NSMutableString alloc] init];
    
    [output appendString:@"Departments:\n"];
    for (LSIDepartment *department in self.departments) {
        [output appendFormat:@"%@", department];
    }
    return output;
}


@end
