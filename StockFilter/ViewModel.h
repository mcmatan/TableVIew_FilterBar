//
// Created by Anton Zagrebelny on 10/10/14.
// Copyright (c) 2014 antonzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewModel : UIViewController

@property BOOL isLoading;

@property(readonly, weak) ViewModel *parent;

-(instancetype) initWithParent: (ViewModel *) parent
                         frame: (CGRect) frame;

- (instancetype)initWithParent:(ViewModel *)parent;


-(void) allocation;
-(void) reload;

@end