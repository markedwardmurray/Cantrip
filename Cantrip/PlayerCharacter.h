//
//  PlayerCharacter.h
//  Cantrip
//
//  Created by Mark Murray on 3/18/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AbilityScore, CharacterRace, ChosenClass, CombatInfo, Skill, SpellBook;

@interface PlayerCharacter : NSManagedObject

@property (nonatomic, retain) NSString * alignment;
@property (nonatomic, retain) NSString * characterName;
@property (nonatomic, retain) NSNumber * inspiration;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSNumber * passiveWisdom;
@property (nonatomic, retain) NSNumber * proficiencyBonus;
@property (nonatomic, retain) NSSet *abilityScores;
@property (nonatomic, retain) CharacterRace *characterRace;
@property (nonatomic, retain) ChosenClass *chosenClass;
@property (nonatomic, retain) CombatInfo *combatInfo;
@property (nonatomic, retain) SpellBook *spellBook;
@property (nonatomic, retain) NSSet *skills;
@end

@interface PlayerCharacter (CoreDataGeneratedAccessors)

- (void)addAbilityScoresObject:(AbilityScore *)value;
- (void)removeAbilityScoresObject:(AbilityScore *)value;
- (void)addAbilityScores:(NSSet *)values;
- (void)removeAbilityScores:(NSSet *)values;

- (void)addSkillsObject:(Skill *)value;
- (void)removeSkillsObject:(Skill *)value;
- (void)addSkills:(NSSet *)values;
- (void)removeSkills:(NSSet *)values;

@end
