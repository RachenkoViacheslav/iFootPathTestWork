//
//  VRWalk.h
//  iFootPath_v2.0
//
//  Created by Admin on 10.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface VRWalk : NSObject

@property (strong, nonatomic) NSString* walkTitle;
@property (strong, nonatomic) NSString* walkRating;
@property (strong, nonatomic) NSString* numsegs;
@property (strong, nonatomic) NSString* walkSegments;
@property (strong, nonatomic) NSString* walkVersion;
@property (strong, nonatomic) NSString* walkIllustration;

@property (strong, nonatomic) NSString* walkPhoto;
@property (strong, nonatomic) NSString* walkStartCoordLat;
@property (strong, nonatomic) NSString* walkDescription;
@property (strong, nonatomic) NSString* walkLength;
@property (strong, nonatomic) NSString* walkDistrict;
@property (strong, nonatomic) NSString* walkID;

@property (strong, nonatomic) NSString* walkGrade;
@property (strong, nonatomic) NSString* walkCounty;
@property (strong, nonatomic) NSString* walkType;
@property (strong, nonatomic) NSString* walkStartCoordLong;
@property (strong, nonatomic) NSString* walkIcon;
@property (strong, nonatomic) NSString* walkPublished;

@property (strong, nonatomic) NSArray* allKeyField;
@property (strong, nonatomic) NSDictionary* walkDictionaryValueForKey;
@property (strong, nonatomic) NSManagedObject* walkManagerObject;


- (id) initWithServerResponse:(NSDictionary*) responseObject;

@end
