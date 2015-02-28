//
//  Spell+Methods.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "Spell.h"

@interface Spell (Methods)

+ (instancetype)createSpellWithContext:(NSManagedObjectContext *)context
                                  name:(NSString *)name
                                 level:(NSNumber *)level
                         schoolOfMagic:(SchoolOfMagic *)schoolOfMagic
                        inSpellLibrary:(SpellLibrary *)spellLibrary
                     forAllowedClasses:(NSArray *)allowedClasses
                           castingTime:(NSString *)castingTime
                                 range:(NSString *)range
                            components:(NSString *)components
                              duration:(NSString *)duration
                      spellDescription:(NSString *)spellDescription;

@end
