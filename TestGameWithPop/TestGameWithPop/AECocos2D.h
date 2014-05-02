//
//  AECocos2D.h
//  CocosUIKitTest
//
//  Created by Paul Solt on 7/4/13.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AECocos2D : NSObject

+ (AECocos2D *)shared;
- (void)setupDirector;
- (CCGLView *)glView;

@end
