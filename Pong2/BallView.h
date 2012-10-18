//
//  BallView.h
//  Pong2
//
//  Created by Alex Hsieh on 10/10/12.
//  Copyright (c) 2012 Alex Hsieh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"

@interface BallView : UIView
{
    CAKeyframeAnimation*    positionAnimation;
    DirectionType           xSourceDirection;
    DirectionType           ySourceDirection;
    
    CGFloat                 containingViewHeight;
    CGFloat                 containingViewWidth;
}

//@property CGFloat containingViewHeight, containingViewWidth;

// ball animation methods
- (void)startAnimation;
- (void)changeDirection: (CGPoint) collisionPoint;

@end