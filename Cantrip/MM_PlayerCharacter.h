//
//  MM_PlayerCharacter.h
//  Cantrip
//
//  Created by Mark Murray on 2/22/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@property (strong, nonatomic) NSNumber *strength;
@property (strong, nonatomic) NSNumber *dexterity;
@property (strong, nonatomic) NSNumber *constitution;
@property (strong, nonatomic) NSNumber *intelligence;
@property (strong, nonatomic) NSNumber *wisdom;
@property (strong, nonatomic) NSNumber *charisma;

// ability bonuses
@property (strong, nonatomic) NSNumber *abilityBonusStrength;
@property (strong, nonatomic) NSNumber *abilityBonusDexterity;
@property (strong, nonatomic) NSNumber *abilityBonusConstitution;
@property (strong, nonatomic) NSNumber *abilityBonusIntelligence;
@property (strong, nonatomic) NSNumber *abilityBonusWisdom;
@property (strong, nonatomic) NSNumber *abilityBonusCharisma;

// proficiencies
@property (strong, nonatomic) NSNumber *proficiencyBonus;
@property (strong, nonatomic) NSNumber *inspiration;
@property (strong, nonatomic) NSNumber *perception;

// saving throws
@property (nonatomic) BOOL canSaveWithStrength;
@property (strong, nonatomic) NSNumber *saveBonusStrength;
@property (nonatomic) BOOL canSaveWithDexterity;
@property (strong, nonatomic) NSNumber *saveBonusDexterity;
@property (nonatomic) BOOL canSaveWithConstitution;
@property (strong, nonatomic) NSNumber *saveBonusConstitution;
@property (nonatomic) BOOL canSaveWithIntelligence;
@property (strong, nonatomic) NSNumber *saveBonusIntelligence;
@property (nonatomic) BOOL canSaveWithWisdom;
@property (strong, nonatomic) NSNumber *saveBonusWisdom;
@property (nonatomic) BOOL canSaveWithCharisma;
@property (strong, nonatomic) NSNumber *saveBonusCharisma;

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
@property (strong, nonatomic) NSMutableArray *spellSlots;

@end
