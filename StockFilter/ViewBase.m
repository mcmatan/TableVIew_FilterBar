//
//  ViewBase.m
//  Stox
//
//  Created by Matan Cohen on 12/19/14.
//  Copyright (c) 2014 Stox. All rights reserved.
//

#import "ViewBase.h"

@implementation ViewBase

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if ([self _loadSelfFromNib]) {
            self = [self _loadSelfFromNib];
        }
                [self initSetup];

    }
    return self;
}

-(instancetype) init {
    if (self = [super init]) {
        if ([self _loadSelfFromNib]) {
            self = [self _loadSelfFromNib];
        }
                [self initSetup];
    }
    return self;
}

-(id) _loadSelfFromNib {
                if ([[NSBundle mainBundle] pathForResource:NSStringFromClass([self class]) ofType:@"nib"]) {
                    
                    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
                    
                }
    
    return nil;
    
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self initSetup];
        
    }
    return self;
    
}

-(void) awakeFromNib {
    [super awakeFromNib];
    
    [self initSetup];
}


-(void) initSetup {

}

@end
