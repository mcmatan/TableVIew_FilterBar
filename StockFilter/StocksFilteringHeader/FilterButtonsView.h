//
//  FilterButtonsView.h
//  StockFilter
//
//  Created by Matan Cohen on 2/26/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterButton.h"
#import "ViewBase.h"

@interface FilterButtonsView : ViewBase

@property (weak, nonatomic) IBOutlet FilterButton *btnFilterOne;
@property (weak, nonatomic) IBOutlet FilterButton *btnFilterTwo;
@property (weak, nonatomic) IBOutlet UILabel *lblFilterOne;
@property (weak, nonatomic) IBOutlet UILabel *lblFilterTwo;
@end
