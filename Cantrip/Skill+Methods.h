//
//  Skill+Methods.h
//  Cantrip
//
//  Created by Mark Murray on 3/18/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "Skill.h"

@interface Skill (Methods)

+ (instancetype)createSkillWithContext:(NSManagedObjectContext *)context
                                  name:(NSString *)name
                       playerCharacter:(PlayerCharacter *)playerCharacter
                          abilityScore:(AbilityScore *)abilityScore;

- (void)toggleProficiency;

@end
