//
//  VRShowDetailInfoViewController.m
//  iFootPath_v2.0
//
//  Created by Admin on 12.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import "VRShowDetailInfoViewController.h"
#import "VRWalk.h"
#import "VRWalkImageCell.h"

#import "VRWalkDescriptionCell.h"
#import "VRWalkParametersCell.h"

#import <UIImageView+AFNetworking.h>
#import "VRCoreDataManager.h"
#import "Entity.h"
#import "VRShowDetailImageViewController.h"
#import "VRNetManager.h"


@interface VRShowDetailInfoViewController ()
{
    NSMutableArray * allKeyFromWalkObjectDict;
    NSMutableDictionary * dictionaryWithKeyAndValueForView;
    
    NSString *stringWithTextField;
    NSString *stringKeyLabelText;
    NSString *stringWithTextView;
}


@end

@implementation VRShowDetailInfoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       self.navigationItem.title = self.walkObjectSelected.walkTitle;
    [self prepareForViewDetailInfo];
}

-(void)prepareForViewDetailInfo {
    
    
    allKeyFromWalkObjectDict = [NSMutableArray array];
    
 NSArray *keys = [[[self.walkObjectSelected entity] attributesByName]allKeys];
  NSDictionary *dict = [self.walkObjectSelected dictionaryWithValuesForKeys:keys];
    
    
    dictionaryWithKeyAndValueForView = [dict mutableCopy];
    
    [dictionaryWithKeyAndValueForView removeObjectForKey:@"walkNumseg"];
    [dictionaryWithKeyAndValueForView removeObjectForKey:@"walkSegments"];
    [dictionaryWithKeyAndValueForView removeObjectForKey:@"walkIllustration"];
    [dictionaryWithKeyAndValueForView removeObjectForKey:@"walkIcon"];
    [dictionaryWithKeyAndValueForView removeObjectForKey:@"walkPhoto"];
    [dictionaryWithKeyAndValueForView removeObjectForKey:@"walkDescription"];
    
    NSArray *newKeyArrayFromMDict = [dictionaryWithKeyAndValueForView allKeys];
    
    for (int i=0; i<newKeyArrayFromMDict.count; i++) {
        NSString *str = newKeyArrayFromMDict[i];
        NSString* updateString = [[str componentsSeparatedByString:@"walk"] lastObject];
        
        [allKeyFromWalkObjectDict addObject:updateString];
    }
 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return [allKeyFromWalkObjectDict count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((indexPath.row == 0)||(indexPath.row == 2)) {
        return 250.f;
    }
    else if (indexPath.row == 1) {
        return 170.f;
    }
    else {
        return 75.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row == 0)||(indexPath.row == 2)) {
        
        static NSString *VRWalkImageCellIdentifier = @"VRWalkImageCell";
        VRWalkImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:VRWalkImageCellIdentifier];
        
   
        NSString *strUrlIcon;
        
        NSArray* folderFileList = [[VRNetManager sharedManager]getListFileName];
        
        if (indexPath.row==2) {
            strUrlIcon =  [NSString stringWithFormat:@"http://www.ifootpath.com/upload/%@", self.walkObjectSelected.walkIllustration];
            
            if (![folderFileList containsObject:self.walkObjectSelected.walkIllustration]) {
                
                NSURL *urlIcon = [NSURL URLWithString:strUrlIcon];
                
                [imageCell.walkImgView setImageWithURL:urlIcon placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            }
            else {
                
                imageCell.imageView.image = [[VRNetManager sharedManager]loadImageWithName:self.walkObjectSelected.walkIllustration];
                
            }
        }
        else {
                strUrlIcon =  [NSString stringWithFormat:@"http://www.ifootpath.com/upload/%@", self.walkObjectSelected.walkPhoto];
            
            if (![folderFileList containsObject:self.walkObjectSelected.walkPhoto]) {
                
                NSURL *urlIcon = [NSURL URLWithString:strUrlIcon];
                
                [imageCell.walkImgView setImageWithURL:urlIcon placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            }
            else {
                
                imageCell.imageView.image = [[VRNetManager sharedManager]loadImageWithName:self.walkObjectSelected.walkPhoto];
                
            }
        }
      
        return imageCell;
    }
    
    else if (indexPath.row == 1) {
    
        
        static NSString *VRWalkDescriptionCellIdentifier = @"VRWalkDescriptionCell";
        VRWalkDescriptionCell *descriptionCell = [tableView dequeueReusableCellWithIdentifier:VRWalkDescriptionCellIdentifier];
        descriptionCell.walkDescription.text = self.walkObjectSelected.walkDescription;
        
        descriptionCell.walkDescription.delegate = self;
        return descriptionCell;
    }
    

    
    
    
    else {
    
     
        
        
        static NSString *walkParametersIdentifier = @"VRWalkParametersCell";
        VRWalkParametersCell *parametersCell = [tableView dequeueReusableCellWithIdentifier:walkParametersIdentifier];
        parametersCell.titleLabel.text = [[dictionaryWithKeyAndValueForView allKeys]objectAtIndex:indexPath.row-3];
        parametersCell.textWalkData.text = [[dictionaryWithKeyAndValueForView allValues]objectAtIndex:indexPath.row-3];
        
  
        
        return parametersCell;
        
    }
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row==0)||(indexPath.row==2)) {
        NSLog(@"selected " );
        
   
        NSString *fileName;
        
        if (indexPath.row==2) {
            fileName =  self.walkObjectSelected.walkIllustration;
        }
        else {
            fileName =  self.walkObjectSelected.walkPhoto;
        }
        
       
        
        [self performSegueWithIdentifier:@"ShowImage" sender:fileName];
        
    }
    else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UITextField *textField = (UITextField *)[cell viewWithTag:101];
        [textField becomeFirstResponder];
    }

}

#pragma mark - viewElements

-(UIToolbar*)createToolbarAboveKeyboardWithSelector:(SEL)selectorMethod {
    
    UIToolbar * keyBoardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    keyBoardToolbar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *fixedItemSpaceWidth = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    
    [keyBoardToolbar setItems: [NSArray arrayWithObjects:
                                
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissKeyBoard) ],fixedItemSpaceWidth,
                                
                                
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:selectorMethod],
                                nil]];
    
    return keyBoardToolbar;
}


#pragma mark - textViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    
    
    UIToolbar * keyBoardToolbar = [self createToolbarAboveKeyboardWithSelector:@selector(saveDescriptionText) ];
    textView.inputAccessoryView = keyBoardToolbar;
    return YES;
}


-(void)textViewDidEndEditing:(UITextView *)textView {
    
    
    stringWithTextView = textView.text;
    
    [textView resignFirstResponder];
}

-(BOOL)textViewShouldReturn:(UITextView *)textView {
    [textView resignFirstResponder];
    
    return YES;
}






#pragma mark - textFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    UIToolbar * keyBoardToolbar = [self createToolbarAboveKeyboardWithSelector:@selector(saveDataFromTextField)];
    textField.inputAccessoryView = keyBoardToolbar;
    
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    UILabel *label = (UILabel *)[textField.superview viewWithTag:100];
    stringKeyLabelText = label.text;
    stringWithTextField = textField.text;
    
       [textField resignFirstResponder];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
   
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
   
    return YES;
}




#pragma mark - Alert
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        
        
        if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"OK"]) {
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
    }
}


#pragma mark - Action
-(void)dismissKeyBoard {
    [self.view endEditing:YES];
}

-(void)saveDescriptionText {
    [self.view endEditing:YES];
    
    
    [[VRCoreDataManager sharedInstance]updateCD:self.walkObjectSelected addText:stringWithTextView forKey:@"walkDescription"];
    
}

- (void)saveDataFromTextField {
    [self.view endEditing:YES];
    
    NSString *keyForWriting = [NSString stringWithFormat:@"%@", stringKeyLabelText];
    
    
    [[VRCoreDataManager sharedInstance]updateCD:self.walkObjectSelected addText:stringWithTextField forKey:keyForWriting];
    
}

-(IBAction)removeItem:(id)sender {
    
    [[VRCoreDataManager sharedInstance]deleteObjectFromCD:self.walkObjectSelected];
    
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Hello" message:@"Object was delete" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.tag = 0;
    [alert show];
    
    
    
}


#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowImage"]) {
        
        VRShowDetailImageViewController* showImageVC = segue.destinationViewController;
        showImageVC.fileName = sender;
        
       
    }
    
    
    
}

@end
