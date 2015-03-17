//
//  ChosenClass+Methods.m
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "ChosenClass+Methods.h"
#import "CharacterClass.h"

@implementation ChosenClass (Methods)

+ (instancetype)createCharacterClassWithContext:(NSManagedObjectContext *)context
                                 characterClass:(CharacterClass *)characterClass {
    ChosenClass *newChosenClass = [NSEntityDescription insertNewObjectForEntityForName:@"ChosenClass" inManagedObjectContext:context];
    newChosenClass.name = characterClass.name;
    [newChosenClass setCharacterClass:characterClass];
    return newChosenClass;
}

@end
