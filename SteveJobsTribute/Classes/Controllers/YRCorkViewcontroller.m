//
//  YRCorkViewcontroller.m
//  SteveJobsTribute
//
//  Created by Jack Perry on 6/10/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "YRCorkViewcontroller.h"

#import <QuartzCore/QuartzCore.h>

@interface YRCorkViewController () {
@private
    
    
    UIImageView                 *tributeImageView;
    MPMoviePlayerController     *tributeMoviePlayer;
    
    UIScrollView *postsScrollView;
    CorkboardContentView *corkboardContentView;
    
    TributeViewController *tributeViewController;
    CreateTributeViewController *createTributeViewController;
    
    NSInteger presentingIndex;
    
    BOOL deviceIsIPad;
    
    BOOL presentingCustomModal;
    
}

- (BOOL)tributeVideoHasBeenPlayed;
- (void)setTributeVideoHasBeenPlayed:(BOOL)status;

- (void)tributeVideoFinished:(MPMoviePlayerController *)finishedPlayer;

- (void)addTribute:(UIBarButtonItem *)sender;

@end




@implementation YRCorkViewController
@synthesize tributeObjects;


- (void)reloadData {
    
    
    [corkboardContentView addPosts:self.tributeObjects];
    
}


#pragma mark - View Lifecycle
- (void)loadView {
    
    
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //!!! bad..... the cork, isn't a pattern.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cork-background"]];
    
    postsScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    postsScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cork-background"]];

    postsScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    corkboardContentView = [[CorkboardContentView alloc] initWithFrame:self.view.frame];
    corkboardContentView.delegate = self;
    corkboardContentView.backgroundColor = [UIColor clearColor];
    
    
    [corkboardContentView addPosts:self.tributeObjects];
    // corkboardContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [postsScrollView addSubview:corkboardContentView];
    [postsScrollView setContentSize:corkboardContentView.frame.size];  
    
    CGFloat w,h;
    
    if (UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        w = (deviceIsIPad)?1024:480;
        h = (deviceIsIPad)?768:320;
    }else{
        w = (deviceIsIPad)?768:321;
        h = (deviceIsIPad)?1024:480;
    }
    
    CGRect newContentFrame = CGRectMake(0, 0, w, h);
    
    postsScrollView.frame = newContentFrame;
    corkboardContentView.layoutOrientation = [[UIDevice currentDevice] orientation];
    postsScrollView.contentSize = corkboardContentView.bounds.size;
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    /* Custom Navigation Bar Title/Label */
    float width = self.navigationController.navigationBar.bounds.size.width;
    float height = self.navigationController.navigationBar.bounds.size.height;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    titleLabel.textColor = UIColorFromRGB(0x79644f);
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLabel.textAlignment = UITextAlignmentCenter;
    
    self.navigationItem.titleView = titleLabel;
    titleLabel.text = NSLocalizedString(@"Steve Jobs Tribute", @"Steve Jobs Tribute");

    
    
    /* Create new Tribute Button */
    UIBarButtonItem *focusTest = [[UIBarButtonItem alloc] initWithTitle:@"Add Tribute" style:UIBarButtonItemStylePlain target:self action:@selector(addTribute:)];

    
    self.navigationItem.rightBarButtonItem = focusTest;
    
    
    
    /* Steve Jobs Tribute */
    tributeImageView = [[UIImageView alloc] init];
    
    NSString *deviceModel = [[UIDevice currentDevice] model];
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGFloat x,y;
        
    NSRange modelRange = [deviceModel rangeOfString:@"iPad"];
    
    if (modelRange.location != NSNotFound) {
        
        deviceIsIPad = YES;
        
        x = (UIInterfaceOrientationIsPortrait(orientation))?-128:0;
        y = (UIInterfaceOrientationIsLandscape(orientation))?-128:0;
        tributeImageView.frame = CGRectMake(x, y, 1024, 1024);
        
        tributeImageView.image = [UIImage imageNamed:@"TributePhoto@2"];//Force Highres
        
    }else{
        
        deviceIsIPad = NO;
        
        x = (UIInterfaceOrientationIsPortrait(orientation))?-80:0;
        y = (UIInterfaceOrientationIsLandscape(orientation))?-80:0;
        tributeImageView.frame = CGRectMake(x, y, 480, 480);
        
        tributeImageView.image = [UIImage imageNamed:@"TributePhoto"];//Autoselect
        
    }
    
    
    tributeImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;  
    
    [self.view addSubview:tributeImageView];
    
    
    tributeViewController = [[TributeViewController alloc] init];
    tributeViewController.delegate = self;
    
    createTributeViewController = [[CreateTributeViewController alloc] init];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    if ([self tributeVideoHasBeenPlayed] == NO) {
        
        NSURL *tributeVideoUrl = [[NSBundle mainBundle] URLForResource:@"TributeVideo" withExtension:@"mp4"];
        
        tributeMoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:tributeVideoUrl];
        tributeMoviePlayer.view.frame = self.view.bounds;
        tributeMoviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:tributeMoviePlayer.view];
        [tributeMoviePlayer play];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tributeVideoFinished:) name:@"MPMoviePlayerPlaybackDidFinishNotification" object:tributeMoviePlayer];
        
    }
    
    
    
}


- (void)viewDidAppear:(BOOL)animated {
       
    if ([self tributeVideoHasBeenPlayed] == YES) {
        [UIView animateWithDuration:2.0 delay:3.0 options:UIViewAnimationCurveEaseInOut animations:^(void) {
        
            tributeImageView.alpha = 0;

        
        } completion:^(BOOL finished) {
        
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            [self.view addSubview:postsScrollView];
        
        }];
        
    }
    
}

- (void)addTribute:(UIBarButtonItem *)sender{
    
    if (presentingCustomModal) 
        [tributeViewController setPresenting:NO];
    
    presentingCustomModal = YES;
    
    [createTributeViewController presentViewFromRect:CGRectZero inView:self.view];
    
}

#pragma mark - CorkboardPostDelegate, TributeViewControllerDelegate, CreateTributeViewControllerDelegate

- (void)tappedPostAtIndex:(NSInteger)index{
    
    if (presentingCustomModal) 
        return;
    
    presentingCustomModal = YES;
    
    [tributeViewController setTribute:[self.tributeObjects objectAtIndex:index]];
    
    if (![tributeViewController isPresenting]){
        [tributeViewController presentViewFromRect:[corkboardContentView postRect:index] inView:self.view];
        [corkboardContentView hidePost:index];
        
        presentingIndex = index;
    }
    
}

- (void)didSendTribute:(YRTribute *)tribute{
    
    presentingCustomModal = NO;
    
    //TODO: upload tribute code
    
}


#pragma mark - Private Methods
- (void)tributeVideoFinished:(MPMoviePlayerController *)finishedPlayer {
    
    [tributeMoviePlayer.view removeFromSuperview];
    [self setTributeVideoHasBeenPlayed:YES];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [self viewDidAppear:YES];
    [self viewDidLoad];
    
}


- (BOOL)tributeVideoHasBeenPlayed {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"kTributeVideoHasBeenPlayed"];
    
}

- (void)setTributeVideoHasBeenPlayed:(BOOL)status {
    
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:@"kTributeVideoHasBeenPlayed"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
    CGFloat w,h;
    
    if (!UIInterfaceOrientationIsLandscape(fromInterfaceOrientation)) {
        w = (deviceIsIPad)?1024:480;
        h = (deviceIsIPad)?768:320;
    }else{
        w = (deviceIsIPad)?768:321;
        h = (deviceIsIPad)?1024:480;
    }
    
    CGRect newContentFrame = CGRectMake(0, 0, w, h);
    
    postsScrollView.frame = newContentFrame;
    corkboardContentView.layoutOrientation = [[UIDevice currentDevice] orientation];
    postsScrollView.contentSize = corkboardContentView.bounds.size;
    
}


#pragma mark - delegate
- (void)didCloseTribute {
    
    
}


@end
