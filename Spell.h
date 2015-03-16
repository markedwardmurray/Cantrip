//
//  Spell.h
//  Cantrip
//
//  Created by Mark Murray on 3/1/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CharacterClass, SchoolOfMagic, SpellBook, SpellLibrary;

@interface Spell : NSManagedObject

@property (nonatomic, retain) NSString * castingTime;
@property (nonatomic, retain) NSString * components;
@property (nonatomic, retain) NSString * duration;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * range;
@property (nonatomic, retain) NSString * spellDescription;
@property (nonatomic, retain) NSString * schoolName;
@property (nonatomic, retain) NSSet *allowedClasses;
@property (nonatomic, retain) SchoolOfMagic *schoolOfMagic;
@property (nonatomic, retain) NSSet *spellBooks;
@property (nonatomic, retain) NSSet *spellLibraries;
@end

@interface Spell (CoreDataGeneratedAccessors)

- (void)addAllowedClassesObject:(CharacterClass *)value;
- (void)removeAllowedClassesObject:(CharacterClass *)value;
- (void)addAllowedClasses:(NSSet *)values;
- (void)removeAllowedClasses:(NSSet *)values;

- (void)addSpellBooksObject:(SpellBook *)value;
- (void)removeSpellBooksObject:(SpellBook *)value;
- (void)addSpellBooks:(NSSet *)values;
- (void)removeSpellBooks:(NSSet *)values;

- (void)addSpellLibrariesObject:(SpellLibrary *)value;
- (void)removeSpellLibrariesObject:(SpellLibrary *)value;
- (void)addSpellLibraries:(NSSet *)values;
- (void)removeSpellLibraries:(NSSet *)values;

@end
