//
//  UIColor+ImageFromColorCatrgory.m
//  StockFilter
//
//  Created by Matan Cohen on 2/26/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//

#import "UIColor+ImageFromColorCatrgory.h"

@implementation UIColor (ImageFromColorCatrgory)

- (UIImage *)imageFromColor;
{
    UIView *colorView = [[UIView alloc] init];
    [colorView setFrame:CGRectMake(0, 0, 20, 20)];
    [colorView setBackgroundColor:self];
    
    UIGraphicsBeginImageContext(CGSizeMake(20, 20));
    [colorView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}
@end
