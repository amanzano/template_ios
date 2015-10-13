//
//  UIFont+PROJECTNAMEFont.h
//  PROJECTNAME
//
//  Created by Audrey Manzano on 8/10/2015.
//  Copyright (c) 2015 Vivant. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PROJECTNAMEFontWeight) {
    PROJECTNAMEFontWeightLight,
    PROJECTNAMEFontWeightRegular,
    PROJECTNAMEFontWeightMedium,
    PROJECTNAMEFontWeightBold,
};

@interface UIFont (PROJECTNAMEFont)

+ (UIFont *)PROJECTNAMEFontWithSize:(CGFloat)size weight:(PROJECTNAMEFontWeight)weight;

@end
