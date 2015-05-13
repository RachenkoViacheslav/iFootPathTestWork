//
//  VRCoreDataManager.h
//  iFootPath_v2.0
//
//  Created by Admin on 10.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VRWalk;
@interface VRCoreDataManager : NSObject

+(instancetype)sharedInstance;
-(NSManagedObjectContext*)getCurrentObjectContext;
-(void)saveDataToCD:(VRWalk*)walkObject;
-(NSArray*)featchRequestResponse;

-(void)updateCD:(NSManagedObject*)walkObject addText:(NSString*)textValue forKey:(NSString*)key;
-(void)deleteObjectFromCD:(NSManagedObject*)walkManagedObject;

-(void)deleteAllItems;
@end
