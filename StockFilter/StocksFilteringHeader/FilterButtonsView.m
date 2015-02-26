
#import "FilterButtonsView.h"

#import "ColorsConstants.h"
@implementation FilterButtonsView

-(void) initSetup {
    [super initSetup];
    
    self.backgroundColor = kColorDarkBlue;
    [self.lblFilterOne setTextColor:kColorLightBlue];
    [self.lblFilterTwo setTextColor:kColorLightBlue];
}
@end
