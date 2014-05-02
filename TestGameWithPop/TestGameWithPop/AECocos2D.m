//
//  AECocos2D.m
//  CocosUIKitTest
//
//  Created by Paul Solt on 7/4/13.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "AECocos2D.h"

static const float kFrameRate = 60;  // can only be 15, 30 or 60

@implementation AECocos2D {
    CCGLView *_glView;
}

static AECocos2D *sharedInstance;

+ (AECocos2D *)shared;
{
    if(!sharedInstance) {
        sharedInstance = [[AECocos2D alloc] init];
        sharedInstance->_glView = [CCGLView viewWithFrame:[[UIScreen mainScreen] bounds]
                                              pixelFormat:kEAGLColorFormatRGBA8
                                              depthFormat:0
                                       preserveBackbuffer:NO
                                               sharegroup:nil
                                            multiSampling:NO
                                          numberOfSamples:0];
        [sharedInstance->_glView setMultipleTouchEnabled:YES];
        [sharedInstance setupDirector];
        [sharedInstance->_glView setFrame:[[UIScreen mainScreen] bounds]];
    }
    return sharedInstance;
}

- (void)setupDirector
{
    CCDirectorIOS *director = (CCDirectorIOS *) [CCDirector sharedDirector];
    
    [director setView:_glView];
    [director enableRetinaDisplay:YES];
    [director setDisplayStats:YES];
    [director setAnimationInterval:1.0/kFrameRate];
}

- (CCGLView *)glView {
    return _glView;
}

@end
