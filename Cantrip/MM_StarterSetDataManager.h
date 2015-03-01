//
//  MM_StarterSetDataManager.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PlayerCharacter;

@interface MM_StarterSetDataManager : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSArray *playerCharactersArray;
@property (strong, nonatomic) NSArray *spellLibrariesArray;
@property (strong, nonatomic) NSArray *characterClassesArray;
@property (strong, nonatomic) NSArray *schoolsOfMagicArray;
@property (strong, nonatomic) NSArray *allSpellsArray;

@property (strong, nonatomic) NSSortDescriptor *sortByCharacterNameAsc;
@property (strong, nonatomic) NSSortDescriptor *sortByNameAsc;
@property (strong, nonatomic) NSSortDescriptor *sortByLevelAsc;
@property (strong, nonatomic) NSSortDescriptor *sortBySchoolOfMagicAsc;

+ (instancetype)sharedStarterSetDataManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)fetchData;

- (NSArray *)filteredAllSpellsForPlayerCharacter:(PlayerCharacter *)playerCharacter;

@end
