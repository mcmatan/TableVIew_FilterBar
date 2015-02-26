//
// Created by Anton Zagrebelny on 10/10/14.
// Copyright (c) 2014 antonzy. All rights reserved.
//

#import <objc/runtime.h>
#import "IViewModelAware.h"


@implementation ViewModel {
    CGRect _frame;
    BOOL _frameIsSet;
}

#pragma mark - init

- (id)loadFromStoryboard {

    NSString *myClassName = NSStringFromClass([self class]);
    NSString *myStoryBoard = [myClassName stringByReplacingOccurrencesOfString:@"ViewModel"
                                                                    withString:@"Storyboard"];

    UIStoryboard *notificationStoryBourd = [UIStoryboard storyboardWithName:myStoryBoard bundle:nil];

    id meClassInstance = [notificationStoryBourd
            instantiateViewControllerWithIdentifier:myClassName];

    return meClassInstance;

}

- (instancetype)initBase {



    self = [super init];
    if (self) {
        [self allocation];
    }
    return self;
}

- (instancetype)init {
    return [self initBase];
}

- (instancetype)initWithParent:(ViewModel *)parent {
    self = [self initBase];
    if (self) {
        _parent = parent;
    }
    return self;
}

- (instancetype)initWithParent:(ViewModel *)parent
                         frame:(CGRect)frame {
    self = [self initBase];
    if (self) {
        _parent = parent;
        _frame = frame;
        _frameIsSet = YES;
    }
    return self;
}

#pragma mark - wake up methods calles

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _setupPresentationStyle];
    [self _disableSwipeToGoBack];


}

- (void)loadView {


    [self loadViewFromFileOrNib];
    [self callViewStarterMethods];



}

- (void)callViewStarterMethods {

    if ([self.view conformsToProtocol:@protocol(IViewModelAware)]) {
        UIView <IViewModelAware> *viewModelAware = (UIView <IViewModelAware> *) self.view;

        [viewModelAware setViewModel:self];

        if ([viewModelAware respondsToSelector:@selector(setupView)]) {
            [viewModelAware setupView];
        }
        if ([viewModelAware respondsToSelector:@selector(bindViewModel)]) {
            [viewModelAware bindViewModel];
        }

    }

}



- (void)loadViewFromFileOrNib {


    NSString *viewName = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"ViewModel"
                                                                                    withString:@"View"];

    UIView *view = [self _createFromTemplate:viewName];

    if (!view) {
        Class cls = NSClassFromString(viewName);

        view = (UIView *) [cls new];
    }

    self.view = view;

    if (_frameIsSet) {
        self.view.frame = _frame;
    }


}


- (UIView *)_createFromTemplate:(NSString *)viewName {
    
    if ([[NSBundle mainBundle] pathForResource:viewName ofType:@"nib"]) {
        return [[[NSBundle mainBundle] loadNibNamed:viewName owner:nil options:nil] firstObject];
    }

    return nil;
}

- (void)allocation {
}


#pragma mark - after view is presented

- (void)reload {

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if ([self.view conformsToProtocol:@protocol(IViewModelAware)]) {
        UIView <IViewModelAware> *viewModelAware = (UIView <IViewModelAware> *) self.view;

        if ([viewModelAware respondsToSelector:@selector(viewAppear)]) {
            [viewModelAware viewAppear];
        }

    }

}


- (void)_setupPresentationStyle {

    self.modalPresentationStyle = UIModalPresentationCurrentContext;

}

- (void)_disableSwipeToGoBack {

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

@end