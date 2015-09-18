//
//  Manager.m
//  PROJECTNAME
//
//  Copyright (c) 2015 Vivant. All rights reserved.
//

#import "Manager.h"

@implementation Manager

+ (instancetype)sharedInstance {
    
    static Manager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[Manager alloc] init];
    });
    
    return manager;
}

@end
