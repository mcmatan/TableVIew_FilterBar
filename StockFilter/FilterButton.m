//
//  FilterButton.m
//  StockFilter
//
//  Created by Matan Cohen on 2/26/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//

#import "FilterButton.h"
#import "UIColor+ImageFromColorCatrgory.h"
#import "ColorsConstants.h"
@implementation FilterButton

-(void) awakeFromNib {
    [super awakeFromNib];
    
    [self _initSetup];
}

-(void) _initSetup {
    
    UIColor *selectedBackroundColor = kColorBlack;
    UIColor *unSelectedBackroundColor = kColorLightBlue;
    
    [self setBackgroundImage:[selectedBackroundColor imageFromColor] forState:UIControlStateSelected];
    [self setBackgroundImage:[unSelectedBackroundColor imageFromColor] forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    
    
}
@end
