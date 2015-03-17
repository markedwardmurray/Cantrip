//
//  CharacterRace+Methods.m
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "CharacterRace+Methods.h"

@implementation CharacterRace (Methods)

+ (instancetype)createCharacterRaceWithContext:(NSManagedObjectContext *)context
                                          name:(NSString *)name
                                   publication:(Publication *)publication
                                   information:(NSString *)information {
    CharacterRace *characterRace = [NSEntityDescription insertNewObjectForEntityForName:@"CharacterRace"
                                                                 inManagedObjectContext:context];
    characterRace.name = name;
    [characterRace setPublication:publication];
    characterRace.information = information;
    return characterRace;
}

@end
