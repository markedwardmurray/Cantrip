//
//  AbilityScore.h
//  Cantrip
//
//  Created by Mark Murray on 3/17/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PlayerCharacter, Skill;

@interface AbilityScore : NSManagedObject

@property (nonatomic, retain) NSNumber * baseScore;
@property (nonatomic, retain) NSNumber * modifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * savingThrow;
@property (nonatomic, retain) NSNumber * isProficient;
@property (nonatomic, retain) PlayerCharacter *playerCharacter;
@property (nonatomic, retain) NSSet *skills;
@end

@interface AbilityScore (CoreDataGeneratedAccessors)

- (void)addSkillsObject:(Skill *)value;
- (void)removeSkillsObject:(Skill *)value;
- (void)addSkills:(NSSet *)values;
- (void)removeSkills:(NSSet *)values;

@end
