//
//  Publication.h
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CharacterClass, CharacterRace, GameSystem, SpellLibrary;

@interface Publication : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) GameSystem *gameSystem;
@property (nonatomic, retain) SpellLibrary *spellLibrary;
@property (nonatomic, retain) NSSet *characterClasses;
@property (nonatomic, retain) NSSet *characterRaces;
@end

@interface Publication (CoreDataGeneratedAccessors)

- (void)addCharacterClassesObject:(CharacterClass *)value;
- (void)removeCharacterClassesObject:(CharacterClass *)value;
- (void)addCharacterClasses:(NSSet *)values;
- (void)removeCharacterClasses:(NSSet *)values;

- (void)addCharacterRacesObject:(CharacterRace *)value;
- (void)removeCharacterRacesObject:(CharacterRace *)value;
- (void)addCharacterRaces:(NSSet *)values;
- (void)removeCharacterRaces:(NSSet *)values;

@end
