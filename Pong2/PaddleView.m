//
//  PaddleView.m
//  Pong2
//
//  Created by Alex Hsieh on 10/10/12.
//  Copyright (c) 2012 Alex Hsieh. All rights reserved.
//

#import "PaddleView.h"
#import "Constants.h"

@implementation PaddleView

//@synthesize distanceFromCenter;
@synthesize autoPlay = _autoPlay;

- (id)initWithCoder:(NSCoder *)coder // We initiate the PaddleView with this function instead of the initWithFrame
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

-(void)setAutoPlay:(BOOL)autoPlay{
    if (autoPlay) {
        [NSTimer scheduledTimerWithTimeInterval:sComputerPaddleSpeed
                                         target:self
                                       selector:@selector(movePaddleDown:)
                                       userInfo:nil repeats:YES];
        _autoPlay = autoPlay;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   if (!_autoPlay) {
        UITouch* touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInView:self.superview];
        
        if (touchLocation.y < self.frame.size.height/2)
        {
            self.center = CGPointMake(self.center.x, self.frame.size.height/2);
        }
        else if (touchLocation.y > (self.superview.frame.size.height - (self.frame.size.height/2)))
        {
            self.center = CGPointMake(self.center.x, (self.superview.frame.size.height - self.frame.size.height/2));
        }
        else {
            self.center = CGPointMake(self.center.x, touchLocation.y);
        }
   }
}

- (void)movePaddleUp:(NSTimer*) timer
{
    if ((self.center.y - (self.frame.size.height/2)) <=  0) {
        [timer invalidate];
        [NSTimer scheduledTimerWithTimeInterval:sComputerPaddleSpeed
                                         target:self
                                       selector:@selector(movePaddleDown:)
                                       userInfo:nil
                                        repeats:YES];
    }
    else{
        self.center = CGPointMake(self.center.x, self.center.y - 1);
    }
}

-(void)movePaddleDown:(NSTimer*)timer
{
    if ((self.center.y + (self.frame.size.height/2)) >=  self.superview.frame.size.height) {
        [timer invalidate];
        [NSTimer scheduledTimerWithTimeInterval:sComputerPaddleSpeed
                                         target:self
                                       selector:@selector(movePaddleUp:)
                                       userInfo:nil
                                        repeats:YES];
    }
    else{
        self.center = CGPointMake(self.center.x, self.center.y + 1);
    }
}

/*
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
 {
 UITouch* touch = [touches anyObject];
 CGPoint touchLocation = [touch locationInView:self.superview];
 
 // find the difference between touchlocation and the center of the view. We will use this to reset the view in touchsMoved function.
 distanceFromCenter = self.center.y - touchLocation.y;
 
 NSLog(@"Touches began x=%f y=%f", self.center.x, self.center.y);
 }
 
 
 - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
 {
 UITouch* touch = [touches anyObject];
 CGPoint touchLocation = [touch locationInView:self.superview];
 NSLog(@"Touches ended x=%f y=%f", touchLocation.x, touchLocation.y);
 }
 */

/*
 - (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
 {
 // double distanceFromCenterAfterHittingBoundary;
 
 UITouch* touch = [touches anyObject];
 CGPoint touchLocation = [touch locationInView:self.superview];
 
 // reset touchlocation.y, so self.center is the touch location + self.center from touchbegan distance from
 // center is negative is south of self.center
 
 touchLocation.y += distanceFromCenter;
 
 NSLog(@"Touches moved x=%f y=%f", touchLocation.x, touchLocation.y);
 
 if (touchLocation.y < self.frame.size.height/2)
 {
 self.center = CGPointMake(self.center.x, self.frame.size.height/2);
 // [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(checkForCollision) userInfo:nil repeats: YES];
 // withinBoundary = false;
 }
 else if (touchLocation.y > (self.superview.frame.size.width - self.frame.size.height/2))
 {
 self.center = CGPointMake(self.center.x, (self.superview.frame.size.width - self.frame.size.height/2));
 // withinBoundary = false;
 }
 else
 {
 self.center = CGPointMake(self.center.x, touchLocation.y);
 }
 }*/


/*
 - (id)initWithFrame:(CGRect)frame
 {
 self = [super initWithFrame:frame];
 if (self) {
 // Initialization code
 }
 return self;
 }
 */

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
