//
//  PlayerCharacter.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CharacterClass, SchoolOfMagic, SpellBook;

@interface PlayerCharacter : NSManagedObject

@property (nonatomic, retain) NSString * characterName;
@property (nonatomic, retain) CharacterClass *characterClass;
@property (nonatomic, retain) SchoolOfMagic *schoolOfMagic;
@property (nonatomic, retain) SpellBook *spellBook;

@end
