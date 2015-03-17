//
//  CharacterClass.h
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ChosenClass, Publication, Spell;

@interface CharacterClass : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *spells;
@property (nonatomic, retain) NSSet *chosenClasses;
@property (nonatomic, retain) Publication *publication;
@end

@interface CharacterClass (CoreDataGeneratedAccessors)

- (void)addSpellsObject:(Spell *)value;
- (void)removeSpellsObject:(Spell *)value;
- (void)addSpells:(NSSet *)values;
- (void)removeSpells:(NSSet *)values;

- (void)addChosenClassesObject:(ChosenClass *)value;
- (void)removeChosenClassesObject:(ChosenClass *)value;
- (void)addChosenClasses:(NSSet *)values;
- (void)removeChosenClasses:(NSSet *)values;

@end
