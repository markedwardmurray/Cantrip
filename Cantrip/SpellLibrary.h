//
//  SpellLibrary.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Spell;

@interface SpellLibrary : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *spells;
@end

@interface SpellLibrary (CoreDataGeneratedAccessors)

- (void)addSpellsObject:(Spell *)value;
- (void)removeSpellsObject:(Spell *)value;
- (void)addSpells:(NSSet *)values;
- (void)removeSpells:(NSSet *)values;

@end
