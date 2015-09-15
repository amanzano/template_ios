//
//  SampleModel.h
//  PROJECTNAME
//
//  Created by USERNAME on TODAY.
//  Copyright (c) 2015 Vivant. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SampleModelType) {
    SampleModelTypeDefault,
    SampleModelType1,
    SampleModelType2
};

static NSString * const kSampleModelConstantName = @"kSampleModelConstantName";

@interface SampleModel : NSObject

@end
