//
//  ChosenClass+Methods.h
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "ChosenClass.h"

@interface ChosenClass (Methods)

+ (instancetype)createCharacterClassWithContext:(NSManagedObjectContext *)context
                                 characterClass:(CharacterClass *)characterClass;

@end
