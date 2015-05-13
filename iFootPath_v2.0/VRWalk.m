//
//  VRWalk.m
//  iFootPath_v2.0
//
//  Created by Admin on 10.05.15.
//  Copyright (c) 2015 Rachenko Viacheslav. All rights reserved.
//

#import "VRWalk.h"

@implementation VRWalk

-(id)initWithServerResponse:(NSDictionary *)responseObject {
    
    self = [super init];
    if (self) {
        
        
        self.walkTitle        = [responseObject objectForKey:@"walkTitle"];
        self.walkRating       = [responseObject objectForKey:@"walkRating"];
        self.numsegs          = [responseObject objectForKey:@"numsegs"];
        self.walkSegments     = [responseObject  objectForKey:@"walkSegments"];
        self.walkVersion      = [responseObject objectForKey:@"walkVersion"];
        self.walkIllustration = [responseObject objectForKey:@"walkIllustration"];

        self.walkPhoto        = [responseObject objectForKey:@"walkPhoto"];
        
        self.walkStartCoordLat = [responseObject objectForKey:@"walkStartCoordLat"];
        self.walkDescription   = [responseObject objectForKey:@"walkDescription"];
        self.walkLength        = [responseObject objectForKey:@"walkLength"];
        self.walkDistrict      = [responseObject objectForKey:@"walkDistrict"];
        self.walkID            = [responseObject objectForKey:@"walkID"];


        self.walkGrade          = [responseObject objectForKey:@"walkGrade"];
        self.walkCounty         = [responseObject objectForKey:@"walkCounty"];
        self.walkType           = [responseObject objectForKey:@"walkType"];
        self.walkStartCoordLong = [responseObject objectForKey:@"walkStartCoordLong"];
        self.walkIcon           = [responseObject objectForKey:@"walkIcon"];
        self.walkPublished      = [responseObject objectForKey:@"walkPublished"];
        
        self.allKeyField        = [responseObject allKeys];
        self.walkDictionaryValueForKey = responseObject;
   
    
    
    
    }
    return self;
    
    
    
    
}



@end
