//
//  GameViewController.h
//  Pong
//
//  Created by Don Bora on 10/8/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import "GameViewController.h"
#import "ResumeGameDelegate.h"

@class PaddleView;

@interface GameViewController : UIViewController <UIAlertViewDelegate, ResumeGameDelegate>
{
    IBOutlet PaddleView*    paddleViewLeft;
    IBOutlet PaddleView*    paddleViewRight;
    IBOutlet UILabel*       oPlayerOneScore;
    IBOutlet UILabel*       oPlayerTwoScore;
    IBOutlet UILabel*       oCountDown;
    IBOutlet UIView*        ballView;
    
    int                     directionY;
    int                     directionX;
    int                     mPlayerOneScore;
    int                     mPlayerTwoScore;
    int                     mCountDown;
}

-(void)moveBall:(NSTimer*)timer;

//-(void)resetBall:(NSTimer*)timer;
-(void)startGame;

@end

//
//  ViewController.h
//  Pong2
//
//  Created by Alex Hsieh on 10/10/12.
//  Copyright (c) 2012 Alex Hsieh. All rights reserved.
//

/*
#import <UIKit/UIKit.h>

@class PaddleView;
@class BallView;

@interface ViewController : UIViewController
{
    IBOutlet PaddleView* paddleViewLeft;
    IBOutlet PaddleView* paddleViewRight;
    IBOutlet BallView*   ballView;
}

@end
*/