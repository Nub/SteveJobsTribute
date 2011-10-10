//
//  TributeViewController.m
//  SteveJobsTribute
//
//  Created by Zachry Thayer on 10/9/11.
//  Copyright (c) 2011 Yoshimi Robotics. All rights reserved.
//

#import "TributeViewController.h"
#import "TributeView.h"

@implementation TributeViewController

@synthesize tribute;

- (void)loadView{
    
    self.view = [[TributeView alloc] initWithFrame:CGRectMake(0, 0, 480, 640)];
    
}

- (void)setTribute:(YRTribute *)newTribute{
    
    if (!newTribute)
        return;
    
    TributeView *tributeView = (id)self.view;
    
    tribute = newTribute;
    
    [tributeView setTitle:   tribute.title];
    [tributeView setAuthor:  tribute.author];
    [tributeView setTribute: tribute.message];
    [tributeView setImage:   tribute.image];
    
    [tributeView setNeedsDisplay];
    
}

@end
