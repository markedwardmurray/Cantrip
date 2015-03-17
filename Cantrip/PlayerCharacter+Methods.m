//
//  PlayerCharacter+Methods.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "PlayerCharacter+Methods.h"
#import "SpellBook+Methods.h"
#import "AbilityScore+Methods.h"
#import "CharacterClass.h"
#import "ChosenClass+Methods.h"

@implementation PlayerCharacter (Methods)

+ (instancetype)createPlayerCharacterWithContext:(NSManagedObjectContext *)context
                                   characterName:(NSString *)characterName
                                  characterClass:(CharacterClass *)characterClass
                                   characterRace:(CharacterRace *)characterRace
                                           level:(NSNumber *)level
                                    strengthRoll:(NSNumber *)strengthRoll
                                   dexterityRoll:(NSNumber *)dexterityRoll
                                constitutionRoll:(NSNumber *)constitutionRoll
                                intelligenceRoll:(NSNumber *)intelligenceRoll
                                      wisdomRoll:(NSNumber *)wisdomRoll
                                    charismaRoll:(NSNumber *)charismaRoll
{
    PlayerCharacter *newPlayerCharacter =
                [NSEntityDescription insertNewObjectForEntityForName:@"PlayerCharacter"
                                              inManagedObjectContext:context];
    newPlayerCharacter.characterName = characterName;
    ChosenClass *chosenClass = [ChosenClass createCharacterClassWithContext:context
                                                             characterClass:characterClass];
    [newPlayerCharacter setChosenClass:chosenClass];
    
    newPlayerCharacter.level = level;
    newPlayerCharacter.proficiencyBonus = @([level integerValue] / 4 + 2);
    
    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Strength"
                                playerCharacter:newPlayerCharacter
                                      baseScore:strengthRoll];
    
    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Dexterity"
                                playerCharacter:newPlayerCharacter
                                      baseScore:dexterityRoll];

    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Constitution"
                                playerCharacter:newPlayerCharacter
                                      baseScore:constitutionRoll];

    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Intelligence"
                                playerCharacter:newPlayerCharacter
                                      baseScore:intelligenceRoll];
    
    AbilityScore *wisdom =
    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Wisdom"
                                playerCharacter:newPlayerCharacter
                                      baseScore:wisdomRoll];

    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Charisma"
                                playerCharacter:newPlayerCharacter
                                      baseScore:charismaRoll];
    
    newPlayerCharacter.passiveWisdom = @([wisdom.modifier integerValue] + 10);
    
    BOOL isSpellCaster = NO;
    if ([characterClass.name isEqualToString:@"Cleric"] ||
        [characterClass.name isEqualToString:@"Wizard"]){
        isSpellCaster = YES;
    }
    
    if (isSpellCaster) {
    NSString *spellBookName = [NSString stringWithFormat:@"%@'s Spell Book", characterName];
    [SpellBook createSpellBookWithContext:context
                                     name:spellBookName
                          playerCharacter:newPlayerCharacter];
    }
    
    return newPlayerCharacter;
}

@end
