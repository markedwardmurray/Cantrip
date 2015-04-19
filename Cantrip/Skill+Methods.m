//
//  Skill+Methods.m
//  Cantrip
//
//  Created by Mark Murray on 3/18/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "Skill+Methods.h"
#import "AbilityScore.h"
#import "PlayerCharacter.h"

@implementation Skill (Methods)

+ (instancetype)createSkillWithContext:(NSManagedObjectContext *)context
                                  name:(NSString *)name
                       playerCharacter:(PlayerCharacter *)playerCharacter
                          abilityScore:(AbilityScore *)abilityScore {
    Skill *newSkill = [NSEntityDescription insertNewObjectForEntityForName:@"Skill"
                                                    inManagedObjectContext:context];
    newSkill.name = name;
    [newSkill setPlayerCharacter:playerCharacter];
    [newSkill setAbilityScore:abilityScore];
    
    newSkill.isProficient = [NSNumber numberWithBool:NO];
    [newSkill calculateModifier];
    
    return newSkill;
}

- (void)calculateModifier {
    if ([self.isProficient boolValue] == NO) {
        self.modifier = self.abilityScore.modifier;
    } else if ([self.isProficient boolValue] == YES) {
        NSInteger abilityModifierInt = [self.abilityScore.modifier integerValue];
        NSInteger proficiencyBonusInt = [self.abilityScore.playerCharacter.proficiencyBonus integerValue];
        self.modifier = @(abilityModifierInt + proficiencyBonusInt);
    }
}

- (void)toggleProficiency {
    if ([self.isProficient boolValue] == NO) {
        self.isProficient = [NSNumber numberWithBool:YES];
        [self calculateModifier];
    } else if ([self.isProficient boolValue] == YES) {
        self.isProficient = [NSNumber numberWithBool:NO];
        [self calculateModifier];
    }
}

@end
