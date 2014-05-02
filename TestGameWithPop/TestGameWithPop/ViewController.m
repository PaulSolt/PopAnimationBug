//
//  ViewController.m
//  TestGameWithPop
//
//  Created by Paul Solt on 5/2/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "AECocos2D.h"
#import "HelloWorldLayer.h"
#import "PanView.h"
#import <POP/POP.h>

#define DISABLE_ANIMATIONS 0

@interface ViewController () {
    NSMutableArray *_panViews;
    
    CGPoint _fromPoint;
    CGPoint _toPoint;
    
    CGPoint _b1Center;
    CGPoint _b2Center;
    CGPoint _b3Center;
    CGPoint _b4Center;
    
}
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UISwitch *onSwitch;
@property (weak, nonatomic) IBOutlet UIButton *b1;
@property (weak, nonatomic) IBOutlet UIButton *b2;
@property (weak, nonatomic) IBOutlet UIButton *b3;
@property (weak, nonatomic) IBOutlet UIButton *b4;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    [[[AECocos2D shared] glView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];

    [self.view insertSubview:[[AECocos2D shared] glView] atIndex:0];
    CCScene *scene = [HelloWorldLayer scene];
//    HelloWorldLayer *layer = (HelloWorldLayer *)[scene.children objectAtIndex:0];

    
    [[CCDirector sharedDirector] runWithScene:scene];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if(!_panViews) {
        _panViews = [[NSMutableArray alloc] init];
        
        // Need to get layout positions after autolayout constraints have been calcluated (3.5" screens will be different here than in viewDidAppear)
        
        PanView *panView = [[PanView alloc] initWithView:self.button];
        [_panViews addObject:panView];
        [_panViews addObject:[[PanView alloc] initWithView:self.b1]];
        [_panViews addObject:[[PanView alloc] initWithView:self.b2]];
        [_panViews addObject:[[PanView alloc] initWithView:self.b3]];
        [_panViews addObject:[[PanView alloc] initWithView:self.b4]];
        
        _b1Center = self.b1.center;
        _b2Center = self.b2.center;
        _b3Center = self.b3.center;
        _b4Center = self.b4.center;
    }
    
    
    NSLog(@"view.bounds: %@", NSStringFromCGRect(self.view.bounds));
    NSLog(@"view.frame: %@", NSStringFromCGRect(self.view.frame));
    NSLog(@"glView.frame: %@", NSStringFromCGRect([[AECocos2D shared] glView].frame));
    [[AECocos2D shared] glView].frame = self.view.bounds;

    
    _toPoint = self.button.center;
    _fromPoint = CGPointMake(_toPoint.x + 50,
                             _fromPoint.y-300);
    
    
    [self animate];
//    [self performSelector:@selector(animate) withObject:nil afterDelay:.5];

}

- (IBAction)buttonPressed:(id)sender {
    [self animate];
}

- (void)clearAnimation {
    
}

- (void)animate {
    
    
//    [self popIn:self.button fromPoint:_fromPoint toPoint:_toPoint];
    [self popIn:self.b1 fromPoint:_fromPoint toPoint:_b1Center];
    [self popIn:self.b2 fromPoint:_fromPoint toPoint:_b2Center];
    
    [self popIn:self.b3 fromPoint:_fromPoint toPoint:_b3Center];
    
    [self popIn:self.b4 fromPoint:_fromPoint toPoint:_b4Center];
}
- (void)popIn:(UIView *)view fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    
//    NSLog(@"Animate from to: %@ %@", NSStringFromCGPoint(fromPoint), NSStringFromCGPoint(toPoint));
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
    animation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];

    animation.springBounciness = 5;
    animation.springSpeed = 20.0;
    animation.dynamicsMass = 3;
    
    animation.completionBlock = ^(POPAnimation *animation, BOOL finished){
        
//        NSLog(@"POPAnimation.completionBlock: %d", finished);
        view.center = toPoint;
        
    };
    [view pop_addAnimation:animation forKey:@"slideOn"];
    
    POPAnimationTracer *tracer = animation.tracer;
    tracer.shouldLogAndResetOnCompletion = YES;
    [tracer start];
    
    
}


@end
