//
//  CharacterRace.h
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PlayerCharacter, Publication;

@interface CharacterRace : NSManagedObject

@property (nonatomic, retain) NSString * information;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *playerCharacters;
@property (nonatomic, retain) Publication *publication;
@end

@interface CharacterRace (CoreDataGeneratedAccessors)

- (void)addPlayerCharactersObject:(PlayerCharacter *)value;
- (void)removePlayerCharactersObject:(PlayerCharacter *)value;
- (void)addPlayerCharacters:(NSSet *)values;
- (void)removePlayerCharacters:(NSSet *)values;

@end
