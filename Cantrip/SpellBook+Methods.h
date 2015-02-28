//
//  SpellBook+Methods.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "SpellBook.h"

@interface SpellBook (Methods)

+ (instancetype)createSpellBookWithContext:(NSManagedObjectContext *)context
                                      name:(NSString *)name
                           playerCharacter:(PlayerCharacter *)playerCharacter;

@end
