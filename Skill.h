//
//  Skill.h
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AbilityScore;

@interface Skill : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * modifier;
@property (nonatomic, retain) NSNumber * isProficient;
@property (nonatomic, retain) AbilityScore *abilityScore;

@end
