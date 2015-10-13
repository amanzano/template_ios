//
//  UIFont+PROJECTNAMEFont.m
//  PROJECTNAME
//
//  Created by Audrey Manzano on 8/10/2015.
//  Copyright (c) 2015 Vivant. All rights reserved.
//

#import "UIFont+PROJECTNAMEFont.h"

@implementation UIFont (PROJECTNAMEFont)

+ (UIFont *)PROJECTNAMEFontWithSize:(CGFloat)size weight:(PROJECTNAMEFontWeight)weight {
    
    switch (weight) {
        case PROJECTNAMEFontWeightLight:
            return [UIFont fontWithName:@"" size:size];
            break;
        case PROJECTNAMEFontWeightRegular:
            return [UIFont fontWithName:@"" size:size];
            break;
        case PROJECTNAMEFontWeightMedium:
            return [UIFont fontWithName:@"" size:size];
            break;
        case PROJECTNAMEFontWeightBold:
            return [UIFont fontWithName:@"" size:size];
            break;
        default:
            [UIFont systemFontOfSize:size];
            break;
    }
}

@end
