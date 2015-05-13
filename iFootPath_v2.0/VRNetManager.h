//
//  VRNetManager.h
//  rssReaderNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "DownloadManager.h"

@interface VRNetManager : NSObject <DownloadManagerDelegate>


+(VRNetManager*) sharedManager;

-(void) getWalkFromSiteURL:(NSString*)siteURLString
                      onSucces:(void(^)(NSArray*walksArrayResponse)) success
                     onFailure:(void(^)(NSError* error, NSInteger statusCode, NSString* errorDescription)) failure;


-(NetworkStatus)checkInternetConnection;

-(void)downloadAllImagesArray:(NSArray*)imageArray;
-(NSArray*)getListFileName;
-(UIImage*)loadImageWithName:(NSString*)fileName;

@property (strong, nonatomic) DownloadManager *downloadManager;
@end
