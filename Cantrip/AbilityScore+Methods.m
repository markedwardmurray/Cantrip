//
//  AbilityScore+Methods.m
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "AbilityScore+Methods.h"
#import "PlayerCharacter.h"

@implementation AbilityScore (Methods)

+ (instancetype)createAbilityScoreWithContext:(NSManagedObjectContext *)context
                                         name:(NSString *)name
                              playerCharacter:(PlayerCharacter *)playerCharacter
                                    baseScore:(NSNumber *)baseScore {
    AbilityScore *abilityScore =
            [NSEntityDescription insertNewObjectForEntityForName:@"AbilityScore"
                                          inManagedObjectContext:context];
    abilityScore.name = name;
    [abilityScore setPlayerCharacter:playerCharacter];
    abilityScore.baseScore = baseScore;

    NSInteger modifierInt = ([abilityScore.baseScore integerValue] - 10) / 2;
    abilityScore.modifier = @(modifierInt);

    NSInteger savingThrowInt = 8 + [abilityScore.playerCharacter.proficiencyBonus integerValue] + modifierInt;
    abilityScore.savingThrow = @(savingThrowInt);
    
    return abilityScore;
}

@end
