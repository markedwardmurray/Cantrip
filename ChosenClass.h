//
//  ChosenClass.h
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CharacterClass, PlayerCharacter, SchoolOfMagic;

@interface ChosenClass : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) PlayerCharacter *playerCharacter;
@property (nonatomic, retain) SchoolOfMagic *schoolOfMagic;
@property (nonatomic, retain) CharacterClass *characterClass;

@end
