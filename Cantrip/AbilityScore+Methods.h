//
//  AbilityScore+Methods.h
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "AbilityScore.h"

@interface AbilityScore (Methods)

+ (instancetype)createAbilityScoreWithContext:(NSManagedObjectContext *)context
                                         name:(NSString *)name
                              playerCharacter:(PlayerCharacter *)playerCharacter
                                    baseScore:(NSNumber *)baseScore;

@end
