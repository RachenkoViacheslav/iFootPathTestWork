//
//  VRShowDetailInfoViewController.h
//  iFootPath_v2.0
//
//  Created by Admin on 12.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Entity;

@interface VRShowDetailInfoViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (strong, nonatomic) Entity* walkObjectSelected;

- (IBAction)removeItem:(id)sender;
@end
