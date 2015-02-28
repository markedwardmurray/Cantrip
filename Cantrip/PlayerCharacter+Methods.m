//
//  PlayerCharacter+Methods.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "PlayerCharacter+Methods.h"
#import "SpellBook+Methods.h"

@implementation PlayerCharacter (Methods)

+ (instancetype)createPlayerCharacterWithContext:(NSManagedObjectContext *)context
                                   characterName:(NSString *)characterName
                                  characterClass:(CharacterClass *)characterClass
{
    PlayerCharacter *newPlayerCharacter =
                [NSEntityDescription insertNewObjectForEntityForName:@"PlayerCharacter"
                                              inManagedObjectContext:context];
    newPlayerCharacter.characterName = characterName;
    [newPlayerCharacter setCharacterClass:characterClass];
    NSString *spellBookName = [NSString stringWithFormat:@"%@'s Spell Book", characterName];
    [SpellBook createSpellBookWithContext:context
                                     name:spellBookName
                          playerCharacter:newPlayerCharacter];
    return newPlayerCharacter;
}

@end
