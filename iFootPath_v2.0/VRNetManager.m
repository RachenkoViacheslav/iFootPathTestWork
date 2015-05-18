//
//  VRNetManager.m
//  rssReaderNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import "VRNetManager.h"
#import "Reachability.h"
#import <AFNetworking.h>
#import "VRWalk.h"
#import "VRCoreDataManager.h"
#import "DownloadManager.h"
#import <UIImageView+AFNetworking.h>



@interface VRNetManager ()
@property (strong, nonatomic)Reachability* networkReachability;
@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;

@end

@implementation VRNetManager



+(VRNetManager *)sharedManager {
    static VRNetManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        manager = [[VRNetManager alloc]init];
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"https://"];
        
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    }
    return self;
}

-(void)downloadAllImagesArray:(NSArray*)imageArray {
 
     /*
    скачиваются все картинки которые есть в приложении и сохраняются в файловой системе устройства 
    (папка downloads/)  для создания оффлайн версии, 
    ведь если кешировать только те картинки которые пользователь видит на экране, 
    то есть вероятность того, что все картинки не будут скачаны и оффлайн версия будет неполной
  */
    
     NSArray* folderFileList = [[VRNetManager sharedManager]getListFileName];
    self.requestOperationManager.operationQueue.maxConcurrentOperationCount=10;
   
    
    self.downloadManager = [[DownloadManager alloc]initWithDelegate:self];
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *downloadFolder = [documentsPath stringByAppendingPathComponent:@"downloads/"];
    
    for (int i=0; i<imageArray.count; i++) {
        

            
                        if (![folderFileList containsObject:imageArray[i]]) {
                
                
            NSString *downloadFilename = [downloadFolder stringByAppendingPathComponent:imageArray[i]];
                
                NSString* fullImageURL =  [NSString stringWithFormat:@"http://www.ifootpath.com/upload/%@",imageArray[i]];
                NSURL *iconUrl = [NSURL URLWithString:fullImageURL];
                
     
                NSLog(@"download image %i ", i );
                
                [self.downloadManager addDownloadWithFilename:downloadFilename URL:iconUrl];
    
           
        }
        
        
    }
}


-(UIImage*)loadImageWithName:(NSString*)fileName {
 
 //загрузить картинку из файл системы
        NSString *path;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [paths[0] stringByAppendingPathComponent:@"downloads/"];
        path = [path stringByAppendingPathComponent:fileName];
        
       UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    
    return image;
}

-(NSArray*)getListFileName {
    //получить список названий всех файлов (имена картинок)
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path = [paths[0] stringByAppendingPathComponent:@"downloads/"];
    
  
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    
    NSError* error = nil;
    NSArray* fileListArray = [fileManager contentsOfDirectoryAtPath:path error:&error];
    
    return fileListArray;
}



-(void) getWalkFromSiteURL:(NSString*)siteURLString
                  onSucces:(void(^)(NSArray*walksArrayResponse)) success
                 onFailure:(void(^)(NSError* error, NSInteger statusCode, NSString* errorDescription)) failure {
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:self.requestOperationManager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    self.requestOperationManager.responseSerializer.acceptableContentTypes = contentTypes;
    
    [self.requestOperationManager POST:siteURLString
                            parameters:nil
                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   NSMutableArray *walkObjectsArray = [NSMutableArray array];
                                   NSArray *walksArray = [responseObject objectForKey:@"walks"];
                                   NSMutableArray* imageNamesArray = [NSMutableArray array];
                                   
                                   for (NSDictionary *walksDictionary in walksArray) {
                                       
                             
                                       VRWalk *walkObject = [[VRWalk alloc]initWithServerResponse:walksDictionary];
                                       
                                       
                                       
                                       [imageNamesArray addObject:walkObject.walkIcon];
                                       [imageNamesArray addObject:walkObject.walkIllustration];
                                       [imageNamesArray addObject:walkObject.walkPhoto];
                                       
                  
                                   
                           [[VRCoreDataManager sharedInstance]saveDataToCD:walkObject];
                           
                           [walkObjectsArray addObject:walkObject];
                                                              }
                
                                   [[VRNetManager sharedManager]downloadAllImagesArray:imageNamesArray];
                     
                       
                       if (success) {
                           NSArray*walkManagedObjArray = [[VRCoreDataManager sharedInstance]featchRequestResponse];
                           NSLog(@"walkManagedObjArray = %i", walkManagedObjArray.count );
                           success (walkManagedObjArray);
                       }
    
                      
                   }
                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       NSLog(@"error = %@", error );
                   }];
    
}

-(NetworkStatus)checkInternetConnection {
     //проверка наличия интернет соединения
    
        self.networkReachability = [Reachability reachabilityForInternetConnection];
    
    return [self.networkReachability currentReachabilityStatus];
}





@end
