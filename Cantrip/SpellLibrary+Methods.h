//
//  SpellLibrary+Methods.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "SpellLibrary.h"

@interface SpellLibrary (Methods)

+ (instancetype)createSpellLibraryWithContext:(NSManagedObjectContext *)context
                                         name:(NSString *)name
                                  publication:(Publication *)publication;

@end
