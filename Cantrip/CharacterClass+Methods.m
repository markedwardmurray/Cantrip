//
//  CharacterClass+Methods.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "CharacterClass+Methods.h"

@implementation CharacterClass (Methods)

+ (instancetype)createCharacterClassWithContext:(NSManagedObjectContext *)context
                                           name:(NSString *)name
{
    CharacterClass *newCharacterClass =
            [NSEntityDescription insertNewObjectForEntityForName:@"CharacterClass"
                                          inManagedObjectContext:context];
    newCharacterClass.name = name;
    return newCharacterClass;
}

@end
