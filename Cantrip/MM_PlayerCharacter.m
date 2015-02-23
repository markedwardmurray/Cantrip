//
//  MM_PlayerCharacter.m
//  Cantrip
//
//  Created by Mark Murray on 2/22/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_PlayerCharacter.h"

@implementation MM_PlayerCharacter

- (instancetype)init
{
    self = [self initWithCharacterName:@"Merlin"
                        characterClass:@"Wizard"
                                 level:@1
                                gender:@"Male"
                                  race:@"Human"
                                   age:@23
                             alignment:@"Neutral Good"
                              strength:@12
                             dexterity:@14
                          constitution:@17
                          intelligence:@18
                                wisdom:@18
                              charisma:@14];
    return self;
}

- (instancetype)initWithCharacterName:(NSString *)characterName
                       characterClass:(NSString *)characterClass
                                level:(NSNumber *)level
                               gender:(NSString *)gender
                                 race:(NSString *)race
                                  age:(NSNumber *)age
                            alignment:(NSString *)alignment
                             strength:(NSNumber *)strength
                            dexterity:(NSNumber *)dexterity
                         constitution:(NSNumber *)constitution
                         intelligence:(NSNumber *)intelligence
                               wisdom:(NSNumber *)wisdom
                             charisma:(NSNumber *)charisma
{
    self = [super init];
    if (self)
    {
        _characterName = characterName;
        _characterClass = characterClass;
        _level = level;
        _gender = gender;
        _race = race;
        _age = age;
        _alignment = alignment;
        _strength = strength;
        _dexterity = dexterity;
        _constitution = constitution;
        _intelligence = intelligence;
        _wisdom = wisdom;
        _charisma = charisma;
    }
    return self;
}

@end
