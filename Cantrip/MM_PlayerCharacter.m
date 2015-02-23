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
        
        if ([characterClass isEqualToString:@"Wizard"] || [characterClass isEqualToString:@"Cleric"])
        {
            _spellSlots = [[MM_SpellSlots alloc]initWithSlotMaximums:@[@3, @2, @0, @0, @0, @0, @0, @0, @0, @0]];
        }
    }
    return self;
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
