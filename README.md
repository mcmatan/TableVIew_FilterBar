# TableVIew_FilterBar

[![Version](https://img.shields.io/cocoapods/v/RJImageLoader.svg?style=flat)](http://cocoadocs.org/docsets/RJImageLoader)

TableVIew_FilterBar is a Quick way to filter your tables view data.
I created this project for the need to filter two deffrent paramiters.


The project uses 'ReactiveCocoa' and 'Masonary' so run 'pod install' before.


## Usage


```objective-c
#import "StocksFilteringHeaderViewModel.h"


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

```


To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Author

Matan Cohen.

##Contributors

Me

## License

No License
