//
//  LSIHRController.h
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSIDepartment;
@class LSIEmployee;

@interface LSIHRController : NSObject

//MARK: - Properties

//@property (nonatomic, readonly) NSArray <LSIEmployee *>*allEmployess;
@property (nonatomic, copy, readonly) NSArray<LSIDepartment *> *departments;
//@property (class, readonly) LSIHRController *sharedController;

//MARK: - Methods

- (void)addDepartment:(LSIDepartment *)department;

- (NSArray<LSIEmployee *> *)allEmployees;

@end

NS_ASSUME_NONNULL_END
