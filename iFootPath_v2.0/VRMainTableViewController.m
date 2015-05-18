//
//  VRMainTableViewController.m
//  iFootPath_v2.0
//
//  Created by Admin on 09.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import "VRMainTableViewController.h"
#import "VRNetManager.h"
#import <MBProgressHUD.h>
#import "VRWalksCustomCell.h"
#import "VRWalk.h"
#import <UIImageView+AFNetworking.h>
#import "VRAppDelegate.h"
#import "VRCoreDataManager.h"
#import "VRShowDetailInfoViewController.h"

static NSString *urlSite = @"http://www.ifootpath.com/API/get_walks.php";

@interface VRMainTableViewController () {
    
}
@property (strong, nonatomic)NSMutableArray *walkArray;
@property (strong,nonatomic) MBProgressHUD *hud;
@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;


@end

@implementation VRMainTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    VRAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    appDelegate.mainViewController = self;
    
    if ([self detectFirstLauchApp]) {
      [self reloadWalkListData];
    }
    else {
        
          [self makeRequest];
    }
}

-(void)reloadWalkListData {
    
    NSArray * resultArray = [[VRCoreDataManager sharedInstance]featchRequestResponse];
    
    self.walkArray =  [NSMutableArray arrayWithArray:resultArray];
    
    [self.tableViewOutlet reloadData];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [self reloadWalkListData];
}

#pragma mark - Make network request
-(void)clearTableViewAndDataSource {
    
    
    [self.walkArray removeAllObjects];
    [self.tableViewOutlet reloadData];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)makeRequest {
    
    if ([[VRNetManager sharedManager]checkInternetConnection]!=NotReachable) {
        [self clearTableViewAndDataSource];
        self.hud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.mode = MBProgressHUDModeIndeterminate;
        self.hud.labelText = @"Loading";
        [[VRNetManager sharedManager]getWalkFromSiteURL:urlSite
                                               onSucces:^(NSArray *walksArrayResponse) {
                                                   self.walkArray = [NSMutableArray arrayWithArray:walksArrayResponse];
                                                   [self.tableViewOutlet reloadData];
                                                   [self.hud hide:YES];
                                                   self.hud = nil;
                                               }
                                              onFailure:^(NSError *error, NSInteger statusCode, NSString *errorDescription) {
                                                  [self.hud hide:YES];
                                                  self.hud = nil;
                                                  
                                              }];

    }
    
    else  {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error"
                                                           message:@"Not internet connection"
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil, nil];
        
        [alertView show];
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

    return [self.walkArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSManagedObject *walkItemObject = [self.walkArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"walksShowInfoCell";
    VRWalksCustomCell  *cell = [self.tableViewOutlet dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[VRWalksCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
        cell.walksTitleLabel.text = [walkItemObject valueForKey:@"walkTitle"] ;
    cell.ratingImage.image = [self imageForRating:[walkItemObject valueForKey:@"walkRating"]];
    cell.walksShortDetailLabel.text = [walkItemObject valueForKey:@"walkDescription"];
    
    
      
    NSString* fullImageURL =  [NSString stringWithFormat:@"http://www.ifootpath.com/upload/%@",[walkItemObject valueForKey:@"walkIcon"]];
    
    NSURL *iconUrl = [NSURL URLWithString:fullImageURL];
    
    
 
    [cell.walksIcon setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
     
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   NSManagedObject* selectedWalkObject = [self.walkArray objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowDetail" sender:selectedWalkObject];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSManagedObject*walkObjectSelected =  [self.walkArray objectAtIndex:indexPath.row];
     [[VRCoreDataManager sharedInstance]deleteObjectFromCD:walkObjectSelected];
    }
    
    [self.walkArray removeObjectAtIndex:indexPath.row];
   
    [self.tableViewOutlet deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (UIImage *)imageForRating:(NSString*)ratingInStringFormat
{
	float rating = [ratingInStringFormat floatValue];
    
    
    
    if (rating<1) {
        return [UIImage imageNamed:@"rating_0_5.png"];
        
    }
    if ((rating==1)||(rating<1.5)) {
        return [UIImage imageNamed:@"rating_1_0.png"];
    }
    else if ((rating<2)&&(rating>=1.5)) {
        return [UIImage imageNamed:@"rating_1_5.png"];
    }
    else if ((rating==2)||(rating<=2.5)) {
        return [UIImage imageNamed:@"rating_2_0.png"];
    }
    else if ((rating<3)&&(rating>=2.5)) {
        return [UIImage imageNamed:@"rating_2_5.png"];
    }
    else if ((rating==3)||(rating<3.5)) {
        return [UIImage imageNamed:@"rating_3_0.png"];
    }
    else if ((rating<4)&&(rating>=3.5)) {
        return [UIImage imageNamed:@"rating_3_5.png"];
    }
    else if ((rating==4)||(rating<4.5)) {
        return [UIImage imageNamed:@"rating_4_0.png"];
    }
    else if ((rating<5)&&(rating>=4.5)) {
        return [UIImage imageNamed:@"rating_4_5.png"];
    }
    else if (rating>4.5) {
        return [UIImage imageNamed:@"rating_5_0.png"];
    }
    
    return nil;
    
}



#pragma mark - Action

-(BOOL)detectFirstLauchApp {
    
        if ([[NSUserDefaults standardUserDefaults]boolForKey:@"FirstLaunch"]) {
        
        
        self.tableViewOutlet.backgroundColor = [UIColor greenColor];
        return YES;
        
    }
    else {
     
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"FirstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.tableViewOutlet.backgroundColor = [UIColor yellowColor];
        
        return NO;
    }

    
}


- (IBAction)updateData:(id)sender {
  
    [[VRCoreDataManager sharedInstance]deleteAllItems];
    [self makeRequest];
    
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        
        VRShowDetailInfoViewController* detailView = segue.destinationViewController;
        detailView.walkObjectSelected = sender;
        
        
    }
    
    
    
}

@end
