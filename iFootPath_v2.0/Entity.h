//
//  Entity.h
//  iFootPath_v2.0
//
//  Created by Admin on 11.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * walkCounty;
@property (nonatomic, retain) NSString * walkDistrict;
@property (nonatomic, retain) NSString * walkGrade;
@property (nonatomic, retain) NSString * walkNumseg;
@property (nonatomic, retain) NSString * walkPublished;
@property (nonatomic, retain) NSString * walkRating;
@property (nonatomic, retain) NSString * walkSegments;
@property (nonatomic, retain) NSString * walkStartCoordLat;
@property (nonatomic, retain) NSString * walkStartCoordLong;
@property (nonatomic, retain) NSString * walkTitle;
@property (nonatomic, retain) NSString * walkVersion;
@property (nonatomic, retain) NSString * walkDescription;
@property (nonatomic, retain) NSString * walkID;
@property (nonatomic, retain) NSString * walkLength;
@property (nonatomic, retain) NSString * walkType;
@property (nonatomic, retain) NSString * walkPhoto;
@property (nonatomic, retain) NSString * walkIcon;
@property (nonatomic, retain) NSString * walkIllustration;


@end
