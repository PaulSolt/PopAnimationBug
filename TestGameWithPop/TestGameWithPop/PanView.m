//
//  CustomView.m
//  PopAnimations
//
//  Created by Paul Solt on 4/30/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "PanView.h"
#import <POP/POP.h>

CGPoint CGPointOffset(CGPoint point, float dx, float dy) {
    return CGPointMake(point.x + dx, point.y + dy);
}

CGPoint CGPointOffsetPoint(CGPoint point, CGPoint offset) {
    return CGPointMake(point.x + offset.x, point.y + offset.y);
}

@interface PanView() {
    CGPoint _baseCenter;
}

@end

@implementation PanView


- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if(self) {
        _view = view;
        _view.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [_view addGestureRecognizer:panGesture];
        
        _baseCenter = _view.center;
        
    }
    return self;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    
    CGPoint translation = [gesture translationInView:gesture.view];
    [gesture setTranslation:CGPointZero inView:gesture.view];
    
    if(UIGestureRecognizerStateBegan == gesture.state ||
       UIGestureRecognizerStateChanged == gesture.state) {
        
        if(UIGestureRecognizerStateBegan == gesture.state) {
            [gesture.view pop_removeAllAnimations];
            //            self.playButton set
        }
        
        
        gesture.view.center = CGPointMake(gesture.view.center.x + translation.x,
                                          gesture.view.center.y + translation.y);
        
    } else if(UIGestureRecognizerStateEnded == gesture.state ||
              UIGestureRecognizerStateCancelled == gesture.state ||
              UIGestureRecognizerStateFailed == gesture.state) {
        
        if(UIGestureRecognizerStateEnded == gesture.state) {
            CGPoint velocity = [gesture velocityInView:gesture.view];
            
            float duration = .12;
            [UIView animateWithDuration:duration animations:^{
                
                
                CGFloat scale = .7;
                CGPoint scaledVelocity = CGPointMake(velocity.x * scale, velocity.y * scale);
                CGPoint distance = CGPointMake(scaledVelocity.x * duration, scaledVelocity.y * duration);
                
                //                             NSLog(@"Scaled V: %@", NSStringFromCGPoint(scaledVelocity));
                
                //                             _centerXConstraint.constant += distance.x;
                //                             _centerYConstraint.constant += distance.y;
                gesture.view.center = CGPointOffsetPoint(gesture.view.center, distance);
                //CGPointMake(self.playButton.center.x + distance.x, gesture.view.center.y + distance.y);
                
                
            } completion:^(BOOL finish) {
                
                [self snapViewToCenter];
                
                
            }];
            
        }
    }

}

- (void)snapViewToCenter {
    
    CGPoint newCenter = _baseCenter;
    
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
    
    animation.toValue = [NSValue valueWithCGPoint:newCenter];
    animation.springBounciness = 5;
    animation.springSpeed = 20.0;
    
    // or for more advanced control
    //    animation.dynamicsTension = 100.0;
    //    animation.dynamicsFriction = 30.0;
    animation.dynamicsMass = 3;
    
    animation.completionBlock = ^(POPAnimation *animation, BOOL finished) {
        NSLog(@"PanView.POP.completionBlock %d", finished);
        self.view.center = _baseCenter;
    };
    
    [self.view pop_addAnimation:animation forKey:@"snap"];
    
}




@end
