//
//  BallView.m
//  Pong2
//
//  Created by Alex Hsieh on 10/10/12.
//  Copyright (c) 2012 Alex Hsieh. All rights reserved.
//

#import "BallView.h"
#define screenBuffer 20

@implementation BallView

- (id)initWithCoder:(NSCoder *)coder // We initiate the PaddleView with this function instead of the initWithFrame
{
    self = [super initWithCoder:coder];
    if (self) {
        positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        [positionAnimation retain];
        
        xSourceDirection = Left;
        ySourceDirection = Bottom;
    }
    return self;
}

- (void)startAnimation
{
    containingViewHeight = self.superview.frame.size.height;
    containingViewWidth  = self.superview.frame.size.width;
    [self animatePath];
}

- (void)animatePath
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, containingViewWidth/2, containingViewHeight/2);
    CGPathAddLineToPoint(path, NULL, (containingViewWidth/4) * 3, -10);
    
    positionAnimation.path = path;
    positionAnimation.calculationMode = kCAAnimationPaced;
    positionAnimation.duration = 1.0f;
    positionAnimation.repeatCount = 0;
    positionAnimation.removedOnCompletion = YES;
    positionAnimation.delegate = self;
    
    [self.layer addAnimation:positionAnimation forKey:@"position"];
}

-(void) changeDirection: (CGPoint) collisionPoint
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    [self.layer removeAnimationForKey:@"position"];
    
    if ((xSourceDirection == Left && ySourceDirection == Bottom) && collisionPoint.y <= self.frame.size.height/2) {
        CGPathMoveToPoint(path, NULL, collisionPoint.x, collisionPoint.y);
        CGPathAddLineToPoint(path, NULL, containingViewWidth + screenBuffer, containingViewWidth - collisionPoint.x);
        NSLog(@"Animating to x=%f y=%f", containingViewWidth + screenBuffer, containingViewWidth - collisionPoint.x);
        ySourceDirection = Top;
        // send the ball left and down
    }
    else if((xSourceDirection == Left && ySourceDirection == Top) && (collisionPoint.x >= containingViewWidth - (self.frame.size.width/2))){
        CGPathMoveToPoint(path, NULL, collisionPoint.x, collisionPoint.y);
        CGPathAddLineToPoint(path, NULL, (containingViewHeight - collisionPoint.y), containingViewHeight + screenBuffer);
        //NSLog(@"Animating to x=%f y=%f", (containingViewHeight - collisionPoint.y), containingViewHeight + screenBuffer);
        xSourceDirection = Right;
        // send the ball right and down
    }
    else if((xSourceDirection == Right && ySourceDirection == Top) && (collisionPoint.y >= containingViewHeight - (self.frame.size.width/2))){
        CGPathMoveToPoint(path, NULL, collisionPoint.x, collisionPoint.y);
        CGPathAddLineToPoint(path, NULL, 0, collisionPoint.x);
        //NSLog(@"Animating to x=%f y=%f", 0.0f - screenBuffer, collisionPoint.x);
        xSourceDirection = Right;
        ySourceDirection = Bottom;
    }
    else if((xSourceDirection == Right && ySourceDirection == Bottom) && (collisionPoint.x <= 0
                                                                          )){
        CGPathMoveToPoint(path, NULL, collisionPoint.x, collisionPoint.y);
        CGPathAddLineToPoint(path, NULL, 0 - screenBuffer, collisionPoint.y);
        NSLog(@"Animating to x=%f y=%f", collisionPoint.y, 0.0f - screenBuffer);
        xSourceDirection = Left;
        ySourceDirection = Bottom;
    }
    
    positionAnimation.path = path;
    //positionAnimation.calculationMode = kCAAnimationPaced;
    //positionAnimation.duration = 1.0f;
    //positionAnimation.repeatCount = 0;
    //positionAnimation.removedOnCompletion = YES;
    positionAnimation.delegate = self;
    
    [self.layer addAnimation:positionAnimation forKey:@"position"];
}

-(void) animationDidStop: (CAAnimation *) animation finished: (BOOL) flag
{
    // [self updatePath];
}
 
- (void)updatePath
{
    CGMutablePathRef path = CGPathCreateMutable();
    
    [self.layer removeAnimationForKey: @"position"];
    
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, self.superview.center.x, self.superview.frame.size.height);
    
    positionAnimation.path = path;
    
    [self.layer addAnimation:positionAnimation forKey:@"position"];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
