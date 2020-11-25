//
//  LSIInternalRevenueService.h
//  KVO KVC
//
//  Created by Alfredo Colon on 9/6/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "LSIEmployee.h"

NS_ASSUME_NONNULL_BEGIN

@class LSIEmployee;


@interface LSIInternalRevenueService : NSObject

 // Shared INstance
@property (class, readonly) LSIInternalRevenueService *sharedService;

// Function to monitor an employee with KVO
- (void)startMonitoringEmployee:(LSIEmployee *)employee;

@end

NS_ASSUME_NONNULL_END
