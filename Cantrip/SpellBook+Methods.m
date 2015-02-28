//
//  SpellBook+Methods.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "SpellBook+Methods.h"

@implementation SpellBook (Methods)

+ (instancetype)createSpellBookWithContext:(NSManagedObjectContext *)context
                                      name:(NSString *)name
                           playerCharacter:(PlayerCharacter *)playerCharacter
{
    SpellBook *newSpellBook =
            [NSEntityDescription insertNewObjectForEntityForName:@"SpellBook"
                                          inManagedObjectContext:context];
    newSpellBook.name = name;
    [newSpellBook setPlayerCharacter:playerCharacter];
    return newSpellBook;
}

@end
