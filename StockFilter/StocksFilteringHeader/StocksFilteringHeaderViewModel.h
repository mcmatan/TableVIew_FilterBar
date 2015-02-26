
#import "ViewModel.h"

@interface StocksFilteringHeaderViewModel : ViewModel


-(instancetype) initWithFilterOneName: (NSString *) filterOneName
                     filterOneOptions: (NSArray *) filterOneOptions
                        filterTwoName: (NSString *) filterTwoName
                     filterTwoOptions: (NSArray *) filterTwoOptions;


@property (nonatomic, strong) NSArray *filterOptions;

@property (nonatomic, strong) NSString *filterOneName;
@property (nonatomic, strong) NSString *filterTwoName;
@property (nonatomic, strong) NSString *selectedFilterOne;
@property (nonatomic, strong) NSString *selectedFilterTwo;

-(void) btnFilterOnePressed;
-(void) btnFilterTwoPressed;

-(void) indexSelected: (NSUInteger) index;

@end
