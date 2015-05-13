//
//  VRImageCell.h
//  iFootPath
//
//  Created by Admin on 18.01.15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRWalkParametersCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *textWalkData;

@end
