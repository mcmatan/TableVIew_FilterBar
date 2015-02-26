//
// Created by Anton Zagrebelny on 10/26/14.
// Copyright (c) 2014 antonzy. All rights reserved.
//

#import "ViewModel.h"

@protocol IViewModelAware

@required

- (void)setViewModel:(ViewModel *)viewModel;

@optional

- (void)setupView;

- (void)bindViewModel;

-(void) viewAppear;
@end