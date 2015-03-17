//
//  CharacterRace+Methods.h
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "CharacterRace.h"

@interface CharacterRace (Methods)

+ (instancetype)createCharacterRaceWithContext:(NSManagedObjectContext *)context
                                          name:(NSString *)name
                                   publication:(Publication *)publication
                                   information:(NSString *)information;

@end
