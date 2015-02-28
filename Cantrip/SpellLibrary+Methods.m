//
//  SpellLibrary+Methods.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "SpellLibrary+Methods.h"

@implementation SpellLibrary (Methods)

+ (instancetype)createSpellLibraryWithContext:(NSManagedObjectContext *)context
                                         name:(NSString *)name
{
    SpellLibrary *newSpellLibrary =
            [NSEntityDescription insertNewObjectForEntityForName:@"SpellLibrary"
                                          inManagedObjectContext:context];
    newSpellLibrary.name = name;
    return newSpellLibrary;
}

@end
