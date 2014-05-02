//
//  CustomView.h
//  PopAnimations
//
//  Created by Paul Solt on 4/30/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PanView : NSObject


- (instancetype)initWithView:(UIView *)view;

@property (nonatomic, weak, readonly) UIView *view;

@end
