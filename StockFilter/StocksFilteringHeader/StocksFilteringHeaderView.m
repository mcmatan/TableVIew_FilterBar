//
// Created by Matan Cohen on 2/23/15.
// Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "StocksFilteringHeaderView.h"
#import "View+MASAdditions.h"
#import "FilterButtonsView.h"
#import "ColorsConstants.h"
#import "StocksFilteringHeaderViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#define CELL_HEIGHT 30

@interface StocksFilteringHeaderView () {
    BOOL _isAnimating;
}

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FilterButtonsView *filterBtnsView;
@property (nonatomic, strong) StocksFilteringHeaderViewModel *viewModel;
@property (nonatomic, strong) MASConstraint *tableConstrain;
@end

@implementation StocksFilteringHeaderView {

}


- (void)setViewModel:(ViewModel *)viewModel {
    _viewModel = viewModel;
}


- (void)setupView {
    [self initSetup];
}

- (void)bindViewModel {
    
    [[RACObserve(self.viewModel, filterOptions) ignore:nil] subscribeNext:^(id x) {
        [self.tableView reloadData];
    }];
    
    RAC(self.filterBtnsView.lblFilterTwo, text) = RACObserve(self.viewModel, filterTwoName);
    RAC(self.filterBtnsView.lblFilterOne, text) = RACObserve(self.viewModel, filterOneName);
    
    [[RACObserve(self.viewModel, selectedFilterOne) ignore:nil] subscribeNext:^(id x) {
        [self.filterBtnsView.btnFilterOne setTitle:x forState:UIControlStateNormal];
        [self.filterBtnsView.btnFilterOne setTitle:x forState:UIControlStateSelected];
    }];
    
    [[RACObserve(self.viewModel, selectedFilterTwo) ignore:nil] subscribeNext:^(id x) {
        [self.filterBtnsView.btnFilterTwo setTitle:x forState:UIControlStateNormal];
        [self.filterBtnsView.btnFilterTwo setTitle:x forState:UIControlStateSelected];
    }];


}

- (void)initSetup {

    self.backgroundColor = kColorLightBlueTransparent;

    NSNumber *filterBtnsViewHeight = @(50);
    NSNumber *tableViewWidth = @(150);

//TableView
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];


    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(tableViewWidth);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@(0));
    }];

//    FilterView
    self.filterBtnsView = [[FilterButtonsView alloc] init];

    [self addSubview:self.filterBtnsView];

    [self.filterBtnsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(filterBtnsViewHeight);
        make.width.equalTo(self.mas_width);
        make.top.equalTo(self.tableView.mas_bottom);
    }];

//    Self
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.tableView.mas_height).offset(self.filterBtnsView.frame.size.height);
    }];

    
    [self.filterBtnsView.btnFilterOne addTarget:self action:@selector(btnFilterOnePress) forControlEvents:UIControlEventTouchUpInside];
    [self.filterBtnsView.btnFilterTwo addTarget:self action:@selector(btnFilterTwoPress) forControlEvents:UIControlEventTouchUpInside];
}

- (void)shrink {

    _isAnimating = YES;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];

        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

            [self.tableView layoutIfNeeded];
            [self layoutIfNeeded];
            [self.superview layoutIfNeeded];
        }                completion:^(BOOL finished) {
            _isAnimating = NO;
            self.filterBtnsView.btnFilterOne.selected = NO;
            self.filterBtnsView.btnFilterTwo.selected = NO;
        }];

}


- (void)graw {

    _isAnimating = YES;
    float tableHight = CELL_HEIGHT * self.viewModel.filterOptions.count;

    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(tableHight));
    }];



    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        [self.tableView layoutIfNeeded];
        [self layoutIfNeeded];
        [self.superview layoutIfNeeded];
    }                completion:^(BOOL finished) {
        _isAnimating = NO;
    }];
}


#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.filterOptions.count;
} 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    cell.textLabel.text = self.viewModel.filterOptions[(NSUInteger) indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = kColorBlack;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isAnimating) {
        return;
    }
    [self.viewModel indexSelected:indexPath.row];
    [self shrink];
}

-(void) changeTableState {
    if (self.tableView.frame.size.height == 0) {
        [self graw];
    } else {
        [self shrink];
    }
}

#pragma mark - Buttons actions

-(void) btnFilterOnePress {
    if (_isAnimating) {
        return;
    }
    
    if (self.tableView.frame.size.height != 0) {
        [self changeTableState];
        return;
    }
    
    [self.viewModel btnFilterOnePressed];
    
    self.filterBtnsView.btnFilterOne.selected = YES;
    if (self.tableConstrain) {
        [self.tableConstrain uninstall];
    }

    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
      self.tableConstrain =   make.centerX.equalTo(self.filterBtnsView.btnFilterOne.mas_centerX);
    }];
    
    [self.tableView layoutIfNeeded];
    

    [self changeTableState];
}

-(void) btnFilterTwoPress {
    if (_isAnimating) {
        return;
    }
    
    if (self.tableView.frame.size.height != 0) {
        [self changeTableState];
        return;
    }
    
        [self.viewModel btnFilterTwoPressed];

    self.filterBtnsView.btnFilterTwo.selected = YES;
    if (self.tableConstrain) {
        [self.tableConstrain uninstall];
    }

    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
     self.tableConstrain =   make.centerX.equalTo(self.filterBtnsView.btnFilterTwo.mas_centerX);
    }];
    
    [self.tableView layoutIfNeeded];
    [self changeTableState];
}



@end