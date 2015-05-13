//
//  VRShowDetailImageViewController.m
//  iFootPath_v2.0
//
//  Created by Admin on 13.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import "VRShowDetailImageViewController.h"
#import <UIImageView+AFNetworking.h>
#import "VRNetManager.h"

@interface VRShowDetailImageViewController ()

@end

@implementation VRShowDetailImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray* folderFileList = [[VRNetManager sharedManager]getListFileName];
    
    if (![folderFileList containsObject:self.fileName]) {
        
        NSURL *urlIcon = [NSURL URLWithString:self.fileName];
        
        [self.imgView setImageWithURL:urlIcon placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    else {
        
        self.imgView.image = [[VRNetManager sharedManager]loadImageWithName:self.fileName];
    }

    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)dismissAnyModel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
