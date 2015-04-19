//
//  Skill.h
//  Cantrip
//
//  Created by Mark Murray on 3/18/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AbilityScore, PlayerCharacter;

@interface Skill : NSManagedObject

@property (nonatomic, retain) NSNumber * isProficient;
@property (nonatomic, retain) NSNumber * modifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) AbilityScore *abilityScore;
@property (nonatomic, retain) PlayerCharacter *playerCharacter;

@end
