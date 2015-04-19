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
#import "Skill+Methods.h"

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
    
    AbilityScore *strength =
    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Strength"
                                playerCharacter:newPlayerCharacter
                                      baseScore:strengthRoll];
    
    AbilityScore *dexterity =
    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Dexterity"
                                playerCharacter:newPlayerCharacter
                                      baseScore:dexterityRoll];

//    AbilityScore *constitution =
    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Constitution"
                                playerCharacter:newPlayerCharacter
                                      baseScore:constitutionRoll];
    
    AbilityScore *intelligence =
    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Intelligence"
                                playerCharacter:newPlayerCharacter
                                      baseScore:intelligenceRoll];
    
    AbilityScore *wisdom =
    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Wisdom"
                                playerCharacter:newPlayerCharacter
                                      baseScore:wisdomRoll];

    AbilityScore *charisma =
    [AbilityScore createAbilityScoreWithContext:context
                                           name:@"Charisma"
                                playerCharacter:newPlayerCharacter
                                      baseScore:charismaRoll];
    
    newPlayerCharacter.passiveWisdom = @([wisdom.modifier integerValue] + 10);
    
    
    [Skill createSkillWithContext:context
                             name:@"Acrobatics"
                  playerCharacter:newPlayerCharacter
                     abilityScore:dexterity];
    
    [Skill createSkillWithContext:context
                             name:@"Animal Handling"
                  playerCharacter:newPlayerCharacter
                     abilityScore:wisdom];
    
    [Skill createSkillWithContext:context
                             name:@"Arcana"
                  playerCharacter:newPlayerCharacter
                     abilityScore:intelligence];
    
    [Skill createSkillWithContext:context
                             name:@"Athletics"
                  playerCharacter:newPlayerCharacter
                     abilityScore:strength];
    
    [Skill createSkillWithContext:context
                             name:@"Deception"
                  playerCharacter:newPlayerCharacter
                     abilityScore:charisma];
    
    [Skill createSkillWithContext:context
                             name:@"History"
                  playerCharacter:newPlayerCharacter
                     abilityScore:intelligence];
    
    [Skill createSkillWithContext:context
                             name:@"Insight"
                  playerCharacter:newPlayerCharacter
                     abilityScore:wisdom];
    
    [Skill createSkillWithContext:context
                             name:@"Intimidation"
                  playerCharacter:newPlayerCharacter
                     abilityScore:charisma];
    
    [Skill createSkillWithContext:context
                             name:@"Investigation"
                  playerCharacter:newPlayerCharacter
                     abilityScore:intelligence];
    
    [Skill createSkillWithContext:context
                             name:@"Medicine"
                  playerCharacter:newPlayerCharacter
                     abilityScore:wisdom];
    
    [Skill createSkillWithContext:context
                             name:@"Nature"
                  playerCharacter:newPlayerCharacter
                     abilityScore:intelligence];
    
    [Skill createSkillWithContext:context
                             name:@"Perception"
                  playerCharacter:newPlayerCharacter
                     abilityScore:wisdom];
    
    [Skill createSkillWithContext:context
                             name:@"Performance"
                  playerCharacter:newPlayerCharacter
                     abilityScore:charisma];
    
    [Skill createSkillWithContext:context
                             name:@"Persuasion"
                  playerCharacter:newPlayerCharacter
                     abilityScore:charisma];
    
    [Skill createSkillWithContext:context
                             name:@"Religion"
                  playerCharacter:newPlayerCharacter
                     abilityScore:intelligence];
    
    [Skill createSkillWithContext:context
                             name:@"Sleight of Hand"
                  playerCharacter:newPlayerCharacter
                     abilityScore:dexterity];
    
    [Skill createSkillWithContext:context
                             name:@"Stealth"
                  playerCharacter:newPlayerCharacter
                     abilityScore:dexterity];
    
    [Skill createSkillWithContext:context
                             name:@"Survival"
                  playerCharacter:newPlayerCharacter
                     abilityScore:wisdom];


    
    
    
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
