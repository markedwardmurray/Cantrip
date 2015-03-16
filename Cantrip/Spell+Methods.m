//
//  Spell+Methods.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "Spell+Methods.h"
#import "SchoolOfMagic.h"

@implementation Spell (Methods)

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
                      spellDescription:(NSString *)spellDescription

{
    Spell *newSpell =
            [NSEntityDescription insertNewObjectForEntityForName:@"Spell"
                                          inManagedObjectContext:context];
    newSpell.name = name;
    newSpell.level = level;
    
    [newSpell setSchoolOfMagic:schoolOfMagic];
    [newSpell addSpellLibrariesObject:spellLibrary];
    [newSpell addAllowedClasses:[NSSet setWithArray:allowedClasses] ];
    
    newSpell.castingTime = castingTime;
    newSpell.range = range;
    newSpell.components = components;
    newSpell.duration = duration;
    newSpell.spellDescription = spellDescription;
    
    newSpell.schoolName = schoolOfMagic.name;
    
    return newSpell;
}

@end
