//
//  VRShowDetailImageViewController.h
//  iFootPath_v2.0
//
//  Created by Admin on 13.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRShowDetailImageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

//@property (strong, nonatomic) NSURL* imageURL;
@property (strong, nonatomic) NSString* fileName;
- (IBAction)dismissAnyModel:(id)sender;
@end
