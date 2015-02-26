//
//  StocksFilteringHeaderViewModel.m
//  StockFilter
//
//  Created by Matan Cohen on 2/26/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//

#import "StocksFilteringHeaderViewModel.h"

@interface StocksFilteringHeaderViewModel ()

@property (nonatomic, strong) NSArray *filterOneOptions;
@property (nonatomic, strong) NSArray *filterTwoOptions;
@end

@implementation StocksFilteringHeaderViewModel

-(instancetype) initWithFilterOneName: (NSString *) filterOneName
                     filterOneOptions: (NSArray *) filterOneOptions
                        filterTwoName: (NSString *) filterTwoName
                     filterTwoOptions: (NSArray *) filterTwoOptions {
    
    if (self = [super init]) {
        
        self.filterOneName = filterOneName;
        self.filterTwoName = filterTwoName;
        
        self.selectedFilterOne = filterOneOptions[1];
        self.selectedFilterTwo = filterTwoOptions[1];
        
        self.filterOneOptions = filterOneOptions;
        self.filterTwoOptions = filterTwoOptions;
    }
    return self;
}

-(void) btnFilterOnePressed {
    self.filterOptions = self.filterOneOptions;
}

-(void) btnFilterTwoPressed {
    self.filterOptions = self.filterTwoOptions;
}

-(void) indexSelected: (NSUInteger) index {
    if ([self.filterOptions isEqualToArray:self.filterOneOptions]) {
        self.selectedFilterOne = self.filterOneOptions[index];
    } else {
        self.selectedFilterTwo = self.filterTwoOptions[index];
    }
}

@end
