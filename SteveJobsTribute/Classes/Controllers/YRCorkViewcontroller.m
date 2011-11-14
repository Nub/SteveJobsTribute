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
    
    MFMailComposeViewController *createTribute;
    
    NSInteger presentingIndex;
    
    BOOL deviceIsIPad;
    
    BOOL presentingCustomModal;
    
}

- (BOOL)tributeVideoHasBeenPlayed;
- (void)setTributeVideoHasBeenPlayed:(BOOL)status;

- (void)tributeVideoFinished:(MPMoviePlayerController *)finishedPlayer;

- (void)addTribute:(UIBarButtonItem *)sender;
- (void)segmentChanged:(UISegmentedControl*)segment;

@end


@interface UINavigationBar (MyCustomNavBar)
@end
@implementation UINavigationBar (MyCustomNavBar)
- (void) drawRect:(CGRect)rect {
    UIImage *barImage = [UIImage imageNamed:@"navbar-background.png"];
    [barImage drawAsPatternInRect:rect];
}
@end

@interface UIBarButtonItem (MyCustomNavBarButton)
@end
@implementation UIBarButtonItem (MyCustomNavBarButton)
- (void) drawRect:(CGRect)rect {
    UIImage *barImage = [[UIImage imageNamed:@"addTributeButton.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [barImage drawInRect:rect];
}
@end


@implementation YRCorkViewController
@synthesize tributeObjects;
@synthesize messages;

- (void)reloadData {
    
    [corkboardContentView addPosts:self.tributeObjects];
    postsScrollView.contentSize = corkboardContentView.bounds.size;
    
}


#pragma mark - View Lifecycle
- (void)loadView {
    
    
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //!!! bad..... the cork, isn't a pattern.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cork-background"]];
    
    postsScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    postsScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cork-background"]];
    postsScrollView.delegate = self;
    postsScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    corkboardContentView = [[CorkboardContentView alloc] initWithFrame:self.view.frame];
    corkboardContentView.delegate = self;
    corkboardContentView.backgroundColor = [UIColor clearColor];
    
    
    [corkboardContentView addPosts:self.tributeObjects];
    // corkboardContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [postsScrollView addSubview:corkboardContentView];
    
    
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

    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:46.f/255.f green:35.f/255.f blue:22.f/255.f alpha:0];
    
    /* Create new Tribute Button */
        
    UIBarButtonItem *focusTest = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTribute:)];
    
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
    
    
    tributeViewController = [[TributeViewController alloc] initWithNibName:@"TributeView" bundle:[NSBundle mainBundle]];
    tributeViewController.delegate = self;
    tributeViewController.modalPresentationStyle = (deviceIsIPad)?UIModalPresentationFormSheet:UIModalPresentationFullScreen;
        
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    CGFloat w,h;
    
    if (UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        w = (deviceIsIPad)?1024:480;
        h = (deviceIsIPad)?768:320;
    }else{
        w = (deviceIsIPad)?768:321;
        h = (deviceIsIPad)?1024:480;
    }
    
    CGRect newContentFrame = CGRectMake(0, 0, w, h-64);
    
    postsScrollView.frame = newContentFrame;
    corkboardContentView.layoutOrientation = [[UIDevice currentDevice] orientation];
    postsScrollView.contentSize = corkboardContentView.bounds.size;
    
    
    if ([self tributeVideoHasBeenPlayed] == NO) {
        
        NSURL *tributeVideoUrl = [[NSBundle mainBundle] URLForResource:@"TributeVideo" withExtension:@"mp4"];
        
        tributeMoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:tributeVideoUrl];
        tributeMoviePlayer.view.frame = self.view.bounds;
        tributeMoviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:tributeMoviePlayer.view];
        [tributeMoviePlayer play];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tributeVideoFinished:) name:@"MPMoviePlayerPlaybackDidFinishNotification" object:tributeMoviePlayer];
        
    }
    
    [corkboardContentView.segmentControl addTarget:self
                         action:@selector(segmentChanged:)
               forControlEvents:UIControlEventValueChanged];
    
    
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
    
    presentingCustomModal = NO;
    
    
    createTribute = [[MFMailComposeViewController alloc] init];
    
    createTribute.modalPresentationStyle = (deviceIsIPad)?UIModalPresentationFormSheet:UIModalPresentationFullScreen;
    createTribute.mailComposeDelegate = self;
    [createTribute setToRecipients:[NSArray arrayWithObject:@"rememberingsteve@apple.com"]];
    
    [self presentModalViewController:createTribute animated:YES];
    
    
}

#pragma mark - CorkboardPostDelegate, TributeViewControllerDelegate, MFMailComposeViewControllerDelegate, UIScrollViewlDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)tappedPostAtIndex:(NSInteger)index{
    
    [tributeViewController setTribute:[self.tributeObjects objectAtIndex:index]];
    presentingIndex = index;

/*    if (deviceIsIPad) {
        if (presentingCustomModal) 
            return;
        
        presentingCustomModal = YES;
                
        if (![tributeViewController isPresenting]){
            [tributeViewController presentViewFromRect:[corkboardContentView postRect:index] inView:self.view];
            [corkboardContentView hidePost:index];
            
        }
    }else{*/
        
        
        [self presentModalViewController:tributeViewController animated:YES];
        
    //}
}

- (void)didSendTribute:(YRTribute *)tribute{
    
    presentingCustomModal = NO;
    
    //TODO: upload tribute code
    
}

- (void)didCloseTribute{
    
    //if (deviceIsIPad) {
    //  presentingCustomModal = NO;
    //   [corkboardContentView showPost:presentingIndex];
    //}else{
        [self dismissModalViewControllerAnimated:YES];
    //}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height - 10) {
        
        YRTribute *lastTribute = [self.tributeObjects lastObject];
        
        [messages tributesFromOffset:lastTribute.databaseRow withRange:60];
        
    }
    
}

- (void)segmentChanged:(UISegmentedControl*)segment{
    
    
    
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
    
    // Only allow portrait on iPhone.
    if (!deviceIsIPad && interfaceOrientation != UIInterfaceOrientationPortrait) {
        return NO;
    }
    
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
    corkboardContentView.layoutOrientation = [[UIDevice currentDevice] orientation];
    postsScrollView.contentSize = corkboardContentView.bounds.size;
    
}



@end
