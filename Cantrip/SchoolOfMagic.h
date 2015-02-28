//
//  SchoolOfMagic.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PlayerCharacter, Spell;

@interface SchoolOfMagic : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *playerCharacters;
@property (nonatomic, retain) NSSet *spells;
@end

@interface SchoolOfMagic (CoreDataGeneratedAccessors)

- (void)addPlayerCharactersObject:(PlayerCharacter *)value;
- (void)removePlayerCharactersObject:(PlayerCharacter *)value;
- (void)addPlayerCharacters:(NSSet *)values;
- (void)removePlayerCharacters:(NSSet *)values;

- (void)addSpellsObject:(Spell *)value;
- (void)removeSpellsObject:(Spell *)value;
- (void)addSpells:(NSSet *)values;
- (void)removeSpells:(NSSet *)values;

@end
