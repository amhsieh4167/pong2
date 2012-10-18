//
//  IntroViewController.h
//  Pong2
//
//  Created by Alex Hsieh on 10/17/12.
//  Copyright (c) 2012 Alex Hsieh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroViewController : UIViewController
{
    IBOutlet UIButton* buttonStartGame;
}

-(IBAction)startGame:(id)sender;

@end
