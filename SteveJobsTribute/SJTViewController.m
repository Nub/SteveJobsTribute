//
//  SJTViewController.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/5/11.
//  Copyright (c) 2011 Zachry Thayer. All rights reserved.
//

#import "SJTViewController.h"

@interface SJTViewController (Private)
    - (void)introVideoFinished:(MPMoviePlayerController *)finishedPlayer;
@end

@implementation SJTViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*UIColor *backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.view.backgroundColor = backgroundColor;*/
    
    NSNumber *didLaunchBefore = [[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLaunch"]; 
    
    if(!didLaunchBefore){
        
        // Set first launch to true
        NSNumber *hasLaunched = [NSNumber numberWithBool:YES];
        [[NSUserDefaults standardUserDefaults] setValue:hasLaunched forKey:@"FirstLaunch"];
        
        
        NSURL *movieUrl = [[NSBundle mainBundle] URLForResource:@"theCrazyOnes" withExtension:@"mp4"];
        
        player = [[MPMoviePlayerController alloc] initWithContentURL: movieUrl];
        [player.view setFrame: self.view.bounds];  // player's frame must match parent's
        [self.view addSubview: player.view];
    
        player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [player play];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(introVideoFinished:) name:@"MPMoviePlayerPlaybackDidFinishNotification" object:player];
        
     }
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
 
    
    return YES;
}


#pragma mark - Private

- (void)introVideoFinished:(MPMoviePlayerController *)finishedPlayer{
    
    [player.view removeFromSuperview];
    
    //[player release];
    
    //Now really load the view
    [self viewDidLoad];
    
}


@end
