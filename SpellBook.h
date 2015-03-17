//
//  SpellBook.h
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PlayerCharacter, Spell;

@interface SpellBook : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) PlayerCharacter *playerCharacter;
@property (nonatomic, retain) NSSet *spells;
@end

@interface SpellBook (CoreDataGeneratedAccessors)

- (void)addSpellsObject:(Spell *)value;
- (void)removeSpellsObject:(Spell *)value;
- (void)addSpells:(NSSet *)values;
- (void)removeSpells:(NSSet *)values;

@end
