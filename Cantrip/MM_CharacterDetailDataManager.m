//
//  MM_CharacterDetailDataManager.m
//  Cantrip
//
//  Created by Mark Murray on 4/20/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_CharacterDetailDataManager.h"
#import "MM_StarterSetDataManager.h"

#import "PlayerCharacter+Methods.h"
#import "AbilityScore+Methods.h"
#import "CharacterRace+Methods.h"
#import "CharacterClass+Methods.h"
#import "ChosenClass+Methods.h"
#import "SchoolOfMagic+Methods.h"
#import "Skill+Methods.h"
#import "SpellBook+Methods.h"



@implementation MM_CharacterDetailDataManager

- (instancetype)initWithPlayerCharacter:(PlayerCharacter *)playerCharacter {
    self = [super init];
    if (self) {
        _starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
        _playerCharacter = playerCharacter;
    }
    return self;
}

- (void)organizeDisplayDataAndSectionHeaders {
    self.displayData = [[NSMutableArray alloc]init];
    self.sectionHeaders = [[NSMutableArray alloc]init];
    
    
    [self organizeCharacterBriefData];
    [self organizeAbilityScoresData];
    [self organizeSkillsData];
    if (self.playerCharacter.spellBook != nil) {
        [self organizeSpellBookData];
    }
}

- (void)organizeCharacterBriefData {
    NSString *characterBriefText = [NSString stringWithFormat:@"Level %@ %@ %@", self.playerCharacter.level, self.playerCharacter.characterRace.name, self.playerCharacter.chosenClass.name];
    NSString *characterBriefDetail = @"";
    if (self.playerCharacter.chosenClass.schoolOfMagic != nil) {
        characterBriefDetail = self.playerCharacter.chosenClass.schoolOfMagic.name;
    }
    NSArray *characterBriefData = @[@[characterBriefText, characterBriefDetail]];
    [self.displayData addObject:characterBriefData];
    [self.sectionHeaders addObject:@""];
}

- (void)organizeAbilityScoresData {
    NSMutableArray *abilityScoresData = [[NSMutableArray alloc]init];
    
    NSString *proficiencyBonusString = [NSString stringWithFormat:@"+%@", self.playerCharacter.proficiencyBonus];
    [abilityScoresData addObject:@[proficiencyBonusString, @"Proficiency Bonus"]];
    
    NSArray *abilityScoreTitles = @[@"Strength", @"Dexterity", @"Constitution", @"Intelligence", @"Wisdom", @"Charisma"];
    NSArray *abilityScoresArray = [self.playerCharacter.abilityScores allObjects];
    for (NSString *currentTitle in abilityScoreTitles) {
        AbilityScore *currentAbility = [abilityScoresArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", currentTitle]][0];
        NSMutableString *currentDetailText = [NSMutableString stringWithFormat:@"%@", currentAbility.baseScore];
        if ([currentAbility.modifier integerValue] >= 0) {
            [currentDetailText appendFormat:@"  (+%@)", currentAbility.modifier];
        } else {
            [currentDetailText appendFormat:@"  (%@)", currentAbility.modifier];
        }
        [abilityScoresData addObject:@[currentTitle, currentDetailText]];
    }
    
    NSString *passiveWisdomString = [NSString stringWithFormat:@"%@", self.playerCharacter.passiveWisdom];
    [abilityScoresData addObject:@[passiveWisdomString, @"Passive Wisdom"]];
    
    [self.displayData addObject:abilityScoresData];
    [self.sectionHeaders addObject:@"ABILITY SCORES"];
}

- (void)organizeSkillsData {
    NSMutableArray *skillsData = [[NSMutableArray alloc]init];
    
    NSArray *skillsArray = [self.playerCharacter.skills allObjects];
    NSArray *sortedSkills = [skillsArray sortedArrayUsingDescriptors:@[self.starterSetDataManager.sortByNameAsc]];
    for (Skill *currentSkill in sortedSkills) {
        NSString *checkBox = @"◻️";
        if ([currentSkill.isProficient boolValue]) {
            checkBox = @"☑️";
        }
        NSString *skillDigits = [NSString stringWithFormat:@"%@ +%@",checkBox, currentSkill.modifier];
        
        NSString *abilityAbbreviation = [currentSkill.abilityScore.name substringToIndex:3];
        NSString *skillText = [NSString stringWithFormat:@"%@ (%@)", currentSkill.name, abilityAbbreviation];
        
        [skillsData addObject:@[skillDigits, skillText]];
    }
    [self.displayData addObject:skillsData];
    [self.sectionHeaders addObject:@"SKILLS"];
}

- (void)organizeSpellBookData {
    NSString *spellBookName = self.playerCharacter.spellBook.name;
    NSString *spellBookSpellsCount = [NSString stringWithFormat:@"%li", [self.playerCharacter.spellBook.spells count]];
    NSArray *spellBookData = @[@[spellBookName, spellBookSpellsCount]];
    [self.displayData addObject:spellBookData];
    [self.sectionHeaders addObject:@"SPELLBOOK"];
}


@end
