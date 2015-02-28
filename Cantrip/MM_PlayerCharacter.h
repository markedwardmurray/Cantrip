//
//  MM_PlayerCharacter.h
//  Cantrip
//
//  Created by Mark Murray on 2/22/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MM_AbilityScore;
@class MM_Spell;
@class MM_SpellSlots;

@interface MM_PlayerCharacter : NSObject

@property (strong, nonatomic) NSString *characterName;
@property (strong, nonatomic) NSString *playerName;

// basic identity
@property (strong, nonatomic) NSString *characterClass;
@property (strong, nonatomic) NSNumber *level;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *race;
@property (strong, nonatomic) NSNumber *age;
@property (strong, nonatomic) NSString *alignment;
@property (strong, nonatomic) NSString *specialization;
@property (strong, nonatomic) NSNumber *experiencePoints;

// ability scores
@property (strong, nonatomic) NSArray *abilityScoresArray;
@property (strong, nonatomic) MM_AbilityScore *strength;
@property (strong, nonatomic) MM_AbilityScore *dexterity;
@property (strong, nonatomic) MM_AbilityScore *constitution;
@property (strong, nonatomic) MM_AbilityScore *intelligence;
@property (strong, nonatomic) MM_AbilityScore *wisdom;
@property (strong, nonatomic) MM_AbilityScore *charisma;

// proficiencies
@property (strong, nonatomic) NSNumber *proficiencyBonus;
@property (strong, nonatomic) NSNumber *inspiration;
@property (strong, nonatomic) NSNumber *perception;





// skill checks
@property (nonatomic) BOOL canUseSkillAcrobatics;
@property (strong, nonatomic) NSNumber *skillBonusAcrobatics;
@property (nonatomic) BOOL canUseSkillAnimalHandling;
@property (strong, nonatomic) NSNumber *skillBonusAnimalHandling;
@property (nonatomic) BOOL canUseSkillArcana;
@property (strong, nonatomic) NSNumber *skillBonusArcana;
@property (nonatomic) BOOL canUseSkillAthletics;
@property (strong, nonatomic) NSNumber *skillBonusAthletics;
@property (nonatomic) BOOL canUseSkillDeception;
@property (strong, nonatomic) NSNumber *skillBonusDeception;
@property (nonatomic) BOOL canUseSkillHistory;
@property (strong, nonatomic) NSNumber *skillBonusHistory;
@property (nonatomic) BOOL canUseSkillInsight;
@property (strong, nonatomic) NSNumber *skillBonusInsight;
@property (nonatomic) BOOL canUseSkillIntimidation;
@property (strong, nonatomic) NSNumber *skillBonusIntimidation;
@property (nonatomic) BOOL canUseSkillInvestigation;
@property (strong, nonatomic) NSNumber *skillBonusInvestigation;
@property (nonatomic) BOOL canUseSkillMedicine;
@property (strong, nonatomic) NSNumber *skillBonusMedicine;
@property (nonatomic) BOOL canUseSkillNature;
@property (strong, nonatomic) NSNumber *skillBonusNature;
@property (nonatomic) BOOL canUseSkillPerception;
@property (strong, nonatomic) NSNumber *skillBonusPerception;
@property (nonatomic) BOOL canUseSkillPerformance;
@property (strong, nonatomic) NSNumber *skillBonusPerformance;
@property (nonatomic) BOOL canUseSkillPersuasion;
@property (strong, nonatomic) NSNumber *skillBonusPersuasion;
@property (nonatomic) BOOL canUseSkillReligion;
@property (strong, nonatomic) NSNumber *skillBonusReligion;
@property (nonatomic) BOOL canUseSkillSleightOfHand;
@property (strong, nonatomic) NSNumber *skillBonusSleightOfHand;
@property (nonatomic) BOOL canUseSkillStealth;
@property (strong, nonatomic) NSNumber *skillBonusStealth;
@property (nonatomic) BOOL canUseSkillSurvival;
@property (strong, nonatomic) NSNumber *skillBonusSurvival;

// combat info
@property (strong, nonatomic) NSNumber *armorClass;
@property (strong, nonatomic) NSNumber *initiative;
@property (strong, nonatomic) NSNumber *speed;
@property (strong, nonatomic) NSNumber *hitPointMaximum;
@property (strong, nonatomic) NSNumber *currentHitPoints;
@property (strong, nonatomic) NSNumber *temporaryHitPoints;

// spells
@property (strong, nonatomic) NSObject *spellBook;
@property (strong, nonatomic) MM_SpellSlots *spellSlots;

- (void)castSpell:(MM_Spell *)spell atLevel:(NSNumber *)level;

@end
