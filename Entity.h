//
//  Entity.h
//  iFootPath_v2.0
//
//  Created by Admin on 10.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * numseg;
@property (nonatomic, retain) NSString * segments;
@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSNumber * startCoordLat;

@property (nonatomic, retain) NSString * walkDescription;
@property (nonatomic, retain) NSNumber * walkLength;
@property (nonatomic, retain) NSString * district;
@property (nonatomic, retain) NSNumber * walkID;
@property (nonatomic, retain) NSNumber * grade;
@property (nonatomic, retain) NSString * county;

@property (nonatomic, retain) NSString * walkType;
@property (nonatomic, retain) NSNumber * startCoordLong;
@property (nonatomic, retain) NSString * published;

@end
