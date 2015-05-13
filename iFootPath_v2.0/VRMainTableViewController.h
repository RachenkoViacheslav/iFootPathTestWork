//
//  VRMainTableViewController.h
//  iFootPath_v2.0
//
//  Created by Admin on 09.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRMainTableViewController : UITableViewController 
- (IBAction)updateData:(id)sender;
- (IBAction)makeRequestAndSaveToCoreData:(id)sender;
-(void)makeRequest;
-(void)clearTableViewAndDataSource;
@end
