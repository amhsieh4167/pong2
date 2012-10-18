//
//  PaddleView.h
//  Pong2
//
//  Created by Alex Hsieh on 10/10/12.
//  Copyright (c) 2012 Alex Hsieh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaddleView : UIView

@property CGFloat distanceFromCenter;
@property(nonatomic, assign)BOOL autoPlay;

-(void)movePaddleUp:  (NSTimer* )timer;
-(void)movePaddleDown:(NSTimer* )timer;

@end