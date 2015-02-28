//
//  MM_PlayerCharacter.m
//  Cantrip
//
//  Created by Mark Murray on 2/22/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_PlayerCharacter.h"
#import "MM_AbilityScore.h"
#import "MM_Spell.h"
#import "MM_SpellSlots.h"

@implementation MM_PlayerCharacter

- (instancetype)init
{
    self = [self initWithCharacterName:@"Merlin"
                            playerName:@"Mark"
                        characterClass:@"Wizard"
                                 level:@1
                                  race:@"Human"
                                   age:@23
                             alignment:@"Neutral Good"
                      experiencePoints:@0
                              strengthScore:@12
                             dexterityScore:@14
                          constitutionScore:@17
                          intelligenceScore:@18
                                wisdomScore:@18
                              charismaScore:@14];
    return self;
}

- (instancetype)initWithCharacterName:(NSString *)characterName
                           playerName:(NSString *)playerName
                       characterClass:(NSString *)characterClass
                                level:(NSNumber *)level
                                 race:(NSString *)race
                                  age:(NSNumber *)age
                            alignment:(NSString *)alignment
                     experiencePoints:(NSNumber *)experiencePoints
                             strengthScore:(NSNumber *)strengthScore
                            dexterityScore:(NSNumber *)dexterityScore
                         constitutionScore:(NSNumber *)constitutionScore
                         intelligenceScore:(NSNumber *)intelligenceScore
                               wisdomScore:(NSNumber *)wisdomScore
                             charismaScore:(NSNumber *)charismaScore
{
    self = [super init];
    if (self)
    {
        _characterName = characterName;
        _playerName = playerName;
        _characterClass = characterClass;
        _level = level;
        _race = race;
        _age = age;
        _alignment = alignment;
        _experiencePoints = experiencePoints;
        
        _strength = [[MM_AbilityScore alloc]initWithName:@"Strength" score:strengthScore];
        _dexterity = [[MM_AbilityScore alloc]initWithName:@"Dexterity" score:dexterityScore];
        _constitution = [[MM_AbilityScore alloc]initWithName:@"Constitution" score:constitutionScore];
        _intelligence = [[MM_AbilityScore alloc]initWithName:@"Intelligence" score:intelligenceScore];
        _wisdom = [[MM_AbilityScore alloc]initWithName:@"Wisdom" score:wisdomScore];
        _charisma = [[MM_AbilityScore alloc]initWithName:@"Charisma" score:charismaScore];
        _abilityScoresArray = @[self.strength, self.dexterity, self.constitution, self.intelligence, self.wisdom, self.charisma];
        
        [self setProficiencyBonusForCharacterClass:characterClass andLevel:level];
        
        if ([characterClass isEqualToString:@"Wizard"] || [characterClass isEqualToString:@"Cleric"])
        {
            self.spellSlots = [[MM_SpellSlots alloc]initWithSlotMaximums:@[@3, @2, @0, @0, @0, @0, @0, @0, @0, @0]];
            if ([level integerValue] > 1)
            {
                [self setSpellSlotsForCharacterClass:characterClass andLevel:level];
            }
        }
        
        
        
        
    }
    return self;
}

- (void)setProficiencyBonusForCharacterClass:(NSString *)characterClass andLevel:(NSNumber *)level
{
    NSInteger levelInt = [level integerValue];
    if ([characterClass isEqualToString:@"Wizard"] || [characterClass isEqualToString:@"Cleric"])
    {
        if (levelInt <= 20)
        {
            NSArray *wizardProficiencies = @[@2, @2, @2, @2, @3, @3, @3, @3, @4, @4, @4, @4, @5, @5, @5, @5, @6, @6, @6, @6];
            NSInteger index = levelInt - 1;
            self.proficiencyBonus = wizardProficiencies[index];
        }
        else if (levelInt > 20)
        {
            NSInteger proficiency = (levelInt / 4) + 2;
            self.proficiencyBonus = @(proficiency);
        }
    }
}

- (void)setSpellSlotsForCharacterClass:(NSString *)characterClass andLevel:(NSNumber *)level
{
    NSInteger index = [level integerValue] - 1;
    
    //up to level 20
    NSArray *slotsMaximumsChart = @[ @[@3, @2, @0, @0, @0, @0, @0, @0, @0, @0],
                                     @[@3, @3, @0, @0, @0, @0, @0, @0, @0, @0], // 2
                                     @[@3, @4, @2, @0, @0, @0, @0, @0, @0, @0],
                                     @[@4, @4, @3, @0, @0, @0, @0, @0, @0, @0], // 4
                                     @[@4, @4, @3, @2, @0, @0, @0, @0, @0, @0],
                                     @[@4, @4, @3, @3, @0, @0, @0, @0, @0, @0], // 6
                                     @[@4, @4, @3, @3, @1, @0, @0, @0, @0, @0],
                                     @[@4, @4, @3, @3, @2, @0, @0, @0, @0, @0], // 8
                                     @[@4, @4, @3, @3, @3, @1, @0, @0, @0, @0],
                                     @[@5, @4, @3, @3, @3, @2, @0, @0, @0, @0], // 10
                                     
                                     @[@5, @4, @3, @3, @3, @2, @1, @0, @0, @0],
                                     @[@5, @4, @3, @3, @3, @2, @1, @0, @0, @0], // 12
                                     @[@5, @4, @3, @3, @3, @2, @1, @1, @0, @0],
                                     @[@5, @4, @3, @3, @3, @2, @1, @1, @0, @0], // 14
                                     @[@5, @4, @3, @3, @3, @2, @1, @1, @1, @0],
                                     @[@5, @4, @3, @3, @3, @2, @1, @1, @1, @0], // 16
                                     @[@5, @4, @3, @3, @3, @2, @1, @1, @1, @1],
                                     @[@5, @4, @3, @3, @3, @3, @1, @1, @1, @1], // 18
                                     @[@5, @4, @3, @3, @3, @3, @2, @1, @1, @1],
                                     @[@5, @4, @3, @3, @3, @3, @2, @2, @1, @1] ];
    
    
    if ([characterClass isEqualToString:@"Wizard"] || [characterClass isEqualToString:@"Cleric"])
    {
        self.spellSlots.slotMaximums = slotsMaximumsChart[index];
    }
}


- (void)castSpell:(MM_Spell *)spell atLevel:(NSNumber *)level
{
    NSInteger levelIndex = [level integerValue];
    if ([self.spellSlots.slotsRemaining[levelIndex] integerValue] > 0)
    {
        [self.spellSlots.spellSlotsArray[levelIndex] addObject:spell];
    }
}


@end
