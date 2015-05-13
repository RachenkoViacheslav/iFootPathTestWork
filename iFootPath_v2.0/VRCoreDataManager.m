//
//  VRCoreDataManager.m
//  iFootPath_v2.0
//
//  Created by Admin on 10.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import "VRCoreDataManager.h"
#import "Entity.h"
#import "VRWalk.h"

@implementation VRCoreDataManager

+(instancetype)sharedInstance {
    
    static VRCoreDataManager* coreDataManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        coreDataManager = [[VRCoreDataManager alloc]init];
    });
    
    return coreDataManager;
}

-(NSManagedObjectContext*)getCurrentObjectContext {
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication]delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)updateCD:(NSManagedObject*)walkObject addText:(NSString*)textValue forKey:(NSString*)key {
    
    NSManagedObjectContext *MOContext = [[VRCoreDataManager sharedInstance] getCurrentObjectContext];
    
    [walkObject setValue:textValue forKey:key];
    
    NSError *error = nil;
    if (![MOContext save:&error]) {
        NSLog(@"Can't save %@ %@",error, [error localizedDescription]);
    }
    else {
        NSLog(@"save is OK" );
    }
    
    
    

    
}

-(void)saveDataToCD:(VRWalk*)walkObject {
    
    NSManagedObjectContext *MOContext = [self getCurrentObjectContext];
    
    
    Entity *entityObject = [NSEntityDescription insertNewObjectForEntityForName:@"Entity" inManagedObjectContext:MOContext];
    
    entityObject.walkTitle          = walkObject.walkTitle;
    entityObject.walkCounty         = walkObject.walkCounty;
    entityObject.walkGrade          = walkObject.walkGrade;
    //entityObject.walkNumseg = walkObject.walkn;
    entityObject.walkPublished      = walkObject.walkPublished;


    entityObject.walkRating         =  walkObject.walkRating;
    //entityObject.walkSegments       = walkObject.walkSegments;
    entityObject.walkVersion        =  walkObject.walkVersion;

    entityObject.walkStartCoordLat  = walkObject.walkStartCoordLat;
    entityObject.walkStartCoordLong = walkObject.walkStartCoordLong;

    entityObject.walkDescription    = walkObject.walkDescription;
    entityObject.walkLength         = walkObject.walkLength;
    entityObject.walkDistrict       = walkObject.walkDistrict;
    entityObject.walkID             = walkObject.walkID;
    entityObject.walkType           = walkObject.walkType;
    
    entityObject.walkPhoto          = walkObject.walkPhoto;
    entityObject.walkIllustration   = walkObject.walkIllustration;
    entityObject.walkIcon           = walkObject.walkIcon;
    
    
    NSError *error = nil;
    if (![MOContext save:&error]) {
        NSLog(@"Can't save %@ %@",error, [error localizedDescription]);
    }
    else {
        NSLog(@"save is OK" );
    }
}

-(void)deleteObjectFromCD:(NSManagedObject*)walkManagedObject {
    
    NSManagedObjectContext *MOContext = [[VRCoreDataManager sharedInstance]getCurrentObjectContext];
 
    
    
    [MOContext deleteObject:walkManagedObject];
    
    NSError *error = nil;
    if (![MOContext save:&error]) {
        NSLog(@"Can't save %@ %@",error, [error localizedDescription]);
    }
    
}

-(NSArray*)featchRequestResponse {
    NSManagedObjectContext *MOContext = [self getCurrentObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
  
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"walkTitle" ascending:YES]];
    NSArray* featchResultArray = [MOContext executeFetchRequest:fetchRequest error:nil];
 
  
    for (NSManagedObject* resultDict in featchResultArray) {
        

        VRWalk *walkObject = [[VRWalk alloc]init];
        walkObject.walkManagerObject = resultDict;
        
    }
    
   
    return featchResultArray;
}

-(void)deleteAllItems {
    
    
    NSManagedObjectContext *managedObjectContext = [[VRCoreDataManager sharedInstance]getCurrentObjectContext];
    
    
    
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Entity" inManagedObjectContext:managedObjectContext]];
    [fetchRequest setIncludesPropertyValues:NO];
    
    NSError * error = nil;
    NSArray * walksArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    //error handling goes here
    for (NSManagedObject * walk in walksArray) {
        [managedObjectContext deleteObject:walk];
    }
    NSError *saveError = nil;
    [managedObjectContext save:&saveError];
}

@end
