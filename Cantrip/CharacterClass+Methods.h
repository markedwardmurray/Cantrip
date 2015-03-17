//
//  CharacterClass+Methods.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "CharacterClass.h"

@interface CharacterClass (Methods)

+ (instancetype)createCharacterClassWithContext:(NSManagedObjectContext *)context
                                           name:(NSString *)name
                                    publication:(Publication *)publication;

@end
