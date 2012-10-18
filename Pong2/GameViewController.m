#import "GameViewController.h"
#import "PaddleView.h"


@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mCountDown = 3;
    
    ballView.center = self.view.center;
    directionX = directionY = 1;
    mPlayerOneScore = mPlayerTwoScore = 0;
    
    oPlayerOneScore.text = [NSString stringWithFormat:@"%i", mPlayerOneScore];
    oPlayerTwoScore.text = [NSString stringWithFormat:@"%i", mPlayerTwoScore];
    
    oPlayerOneScore.font = [UIFont fontWithName:@"SFAtarianSystem" size:43];
    oPlayerTwoScore.font = [UIFont fontWithName:@"SFAtarianSystem" size:43];
    oCountDown.font      = [UIFont fontWithName:@"SFAtarianSystem" size:43];
    
    ballView.alpha = 0.0f;
    oCountDown.alpha = 1.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft );
}

-(void)startGame
{
    oCountDown.text = [NSString stringWithFormat:@"%i", mCountDown];
    [self startCountdownTimer];
}

-(void)resetGame
{
    mPlayerOneScore = mPlayerTwoScore = 0;
    oPlayerOneScore.text = @"0";
    oPlayerTwoScore.text = @"0";
    [self resetBall:nil];
}

-(void)countDown:(NSTimer*)timer
{
    mCountDown--;
    
    if (mCountDown < 0) {
        [timer invalidate];
        ballView.alpha = 1.0f;
        oCountDown.alpha = 0.0f;
        paddleViewRight.autoPlay = YES;
        [self startGameTimer];
    }
    else{
        oCountDown.text = [NSString stringWithFormat:@"%i", mCountDown];
    }
}

-(void)resetBall:(NSTimer*)timer
{
    [timer invalidate];
    if (mPlayerTwoScore >= 1) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Win"
                                                            message:@"Someone lost"
                                                           delegate:self
                                                  cancelButtonTitle:@"No thanks, I suck"
                                                  otherButtonTitles:@"Bring it!", nil];
        [alertView show];
        [alertView release];
    }
    else{
        ballView.center = self.view.center;
        directionY *= -1;
        directionX *= -1;
        [self startGameTimer];
    }
}

-(void)moveBall:(NSTimer*)timer
{
    if ((ballView.frame.origin.y + ballView.frame.size.width > self.view.frame.size.height) ||
        (ballView.frame.origin.y < 0))
    {
        directionY *= -1;
    }
    
    if (ballView.frame.origin.x + ballView.frame.size.height > self.view.frame.size.width){
        [self resetBall:timer];
        mPlayerOneScore++;
        oPlayerOneScore.text = [NSString stringWithFormat:@"%i", mPlayerOneScore];
    }
    else if(ballView.frame.origin.x < 0){
        [self resetBall:timer];
        mPlayerTwoScore++;
        oPlayerTwoScore.text = [NSString stringWithFormat:@"%i", mPlayerTwoScore];
    }
    
    if (CGRectIntersectsRect(ballView.frame, paddleViewLeft.frame)) {
        ballView.center = CGPointMake(ballView.center.x+2, ballView.center.y);
        directionX *= -1;
        directionY *= -1;
    }
    else if (CGRectIntersectsRect(ballView.frame, paddleViewRight.frame)) {
        ballView.center = CGPointMake(ballView.center.x-2, ballView.center.y);
        directionX *= -1;
        directionY *= -1;
    }
    
    ballView.center = CGPointMake(ballView.center.x + directionX, ballView.center.y + directionY);
}

-(void)startGameTimer
{
    [NSTimer scheduledTimerWithTimeInterval:0.005f target:self selector:@selector(moveBall:) userInfo:nil repeats:YES];
}

-(void)startCountdownTimer
{
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self.view removeFromSuperview];
            break;
            
        case 1:
            [self resetGame];
        default:
            break;
    }
}

@end
//
//  ViewController.m
//  Pong
//
//  Created by Don Bora on 10/8/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//



/*
#import "GameViewController.h"
#import "PaddleView.h"

@interface GameViewController ()

@end

@implementation GameViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [paddleViewRight autoPlay];
    
    ballView.center = self.view.center;
    directionX = directionY = 1;
    mPlayerOneScore = mPlayerTwoScore = 0;
    
    oPlayerOneScore.text = [NSString stringWithFormat:@"%i", mPlayerOneScore];
    oPlayerTwoScore.text = [NSString stringWithFormat:@"%i", mPlayerTwoScore];
    
    [self startTimer];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft );
}

-(void)resetGame
{
    mPlayerOneScore = mPlayerTwoScore = 0;
    oPlayerOneScore.text = @"0";
    oPlayerTwoScore.text = @"0";
    [self resetBall:nil];
}

-(void)resetBall: (NSTimer*)timer
{
    [timer invalidate];
    if (mPlayerOneScore >= 1 || mPlayerTwoScore >= 1) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Win"
                                                            message:@"Someone lost"
                                                           delegate:self
                                                  cancelButtonTitle:@"No thanks, I suck"
                                                  otherButtonTitles:@"Bring it!", nil];
        [alertView show];
        [alertView release];
    }
    else {
        ballView.center = self.view.center;
        directionY *= -1;
        directionX *= -1;
        [self startTimer];
    }
}

-(void) moveBall: (NSTimer*) timer
{
    NSLog(@"width = %f, height = %f", self.view.frame.size.width, self.view.frame.size.height);
    if ((ballView.frame.origin.y + ballView.frame.size.width > self.view.frame.size.width) || (ballView.frame.origin.y < 0)) {
        // ball hits the top and bottom
        directionY *= -1;
    }
    
    if (ballView.frame.origin.x + ballView.frame.size.height > self.view.frame.size.height) {
        
        // ball hits the right side
        mPlayerOneScore++;
        oPlayerOneScore.text = [NSString stringWithFormat:@"%i", mPlayerOneScore];
        [self resetBall: timer];
    }
    else if(ballView.frame.origin.x < 0)
    {
        // ball hits the left side
        
        mPlayerTwoScore++;
        oPlayerTwoScore.text = [NSString stringWithFormat:@"%i", mPlayerTwoScore];
        [self resetBall: timer];
    }
    
    if (CGRectIntersectsRect(ballView.frame, paddleViewLeft.frame)) {
        directionX *= -1;
        directionY *= -1;
    }
    else if (CGRectIntersectsRect(ballView.frame, paddleViewRight.frame)) {
        directionX *= -1;
        directionY *= -1;
    }
         
    ballView.center = CGPointMake(ballView.center.x + directionX, ballView.center.y + directionY);
}

-(void)startTimer
{
    [NSTimer scheduledTimerWithTimeInterval:0.005f target:self selector:@selector(moveBall:) userInfo:nil repeats:YES];   
}
    
#pragma mark UIAlertViewDelegate
    
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            //ballView.center = self.view.center;
            ballView.Center = CGPointMake(240, 160);
            NSLog(@"x = %f, y = %f", self.view.center.x, self.view.center.y);
            break;
        case 1:
            [self resetGame];
            break;
        default:
            break;
    }
}

@end */