//
//  ViewController.m
//  StockFilter
//
//  Created by Matan Cohen on 2/23/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//


#import "ViewController.h"
#import "View+MASAdditions.h"
#import "MASConstraintMaker.h"
#import "StocksFilteringHeaderView.h"
#import "StocksFilteringHeaderViewModel.h"

@interface ViewController ()


@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) StocksFilteringHeaderViewModel *filterViewModel;
@property(nonatomic, strong) UIView *tableHeaderStatic;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Table
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tableView];;
    
    //Some SegmentedController
    
    NSArray *filterOneOption = @[@"NASDAQ", @"NYSE", @"London", @"Frankfurt"];
    NSArray *filterTwoOption = @[@"Volume", @"Price", @"Daily Change"];
    
    self.filterViewModel = [[StocksFilteringHeaderViewModel alloc] initWithFilterOneName:@"Filter By:" filterOneOptions:filterOneOption filterTwoName:@"Sort By:" filterTwoOptions:filterTwoOption];
    [self.view addSubview:self.filterViewModel.view];
    
    
    self.tableHeaderStatic = [[UIView alloc] init];
    self.tableHeaderStatic.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableHeaderStatic];


    NSNumber *headerHegiht = @(40);



    [self.tableHeaderStatic mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.equalTo(headerHegiht);
    }];

    [self.filterViewModel.view mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.tableHeaderStatic.mas_bottom);
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.filterViewModel.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];



}



@end