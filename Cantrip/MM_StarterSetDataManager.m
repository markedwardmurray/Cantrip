//
//  MM_StarterSetDataManager.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_StarterSetDataManager.h"
#import "MM_StarterSetDataGenerator.h"
#import "GameSystem.h"
#import "Publication.h"
#import "PlayerCharacter+Methods.h"
#import "CharacterClass+Methods.h"
#import "ChosenClass+Methods.h"
#import "Spell+Methods.h"
#import "SpellBook+Methods.h"
#import "SchoolOfMagic+Methods.h"
#import "SpellLibrary+Methods.h"
#import "CharacterRace+Methods.h"
#import "Skill+Methods.h"

@interface MM_StarterSetDataManager ()

@property MM_StarterSetDataGenerator *starterSetDataGenerator;

@end

@implementation MM_StarterSetDataManager

@synthesize managedObjectContext = _managedObjectContext;

# pragma mark - Singleton

+ (instancetype)sharedStarterSetDataManager {
    static MM_StarterSetDataManager *_sharedStarterSetDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       _sharedStarterSetDataManager  = [[MM_StarterSetDataManager alloc] init];
    });
    
    return _sharedStarterSetDataManager;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)defineSortDescriptors
{
    self.sortByCharacterNameAsc = [NSSortDescriptor sortDescriptorWithKey:@"characterName"
                                                                        ascending:YES];
    self.sortByNameAsc = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                ascending:YES];
    self.sortByLevelAsc = [NSSortDescriptor sortDescriptorWithKey:@"level"
                                                        ascending:YES];
    self.sortBySchoolNameAsc = [NSSortDescriptor sortDescriptorWithKey:@"schoolName"
                                                             ascending:YES];
}

- (void)fetchData
{
    self.starterSetDataGenerator = [[MM_StarterSetDataGenerator alloc]init];
    [self defineSortDescriptors];
    
    NSFetchRequest *gameSystemsRequest = [NSFetchRequest fetchRequestWithEntityName:@"GameSystem"];
    gameSystemsRequest.sortDescriptors = @[self.sortByNameAsc];
    self.gameSystems = [self.managedObjectContext executeFetchRequest:gameSystemsRequest error:nil];
    if ([self.gameSystems count] == 0) {
        GameSystem *dnd5thEdition = [NSEntityDescription insertNewObjectForEntityForName:@"GameSystem" inManagedObjectContext:self.managedObjectContext];
        dnd5thEdition.name = @"Dungeons & Dragons 5th Edition";
        dnd5thEdition.publisher = @"Wizards of the Coast";
        [self saveContext];
        [self fetchData];
    }
    
    NSFetchRequest *publicationsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Publication"];
    publicationsRequest.sortDescriptors = @[self.sortByNameAsc];
    self.publications = [self.managedObjectContext executeFetchRequest:publicationsRequest error:nil];
    if ([self.publications count] == 0) {
        [self.starterSetDataGenerator generatePublication];
    }

    NSFetchRequest *characterRacesRequest = [NSFetchRequest fetchRequestWithEntityName:@"CharacterRace"];
    characterRacesRequest.sortDescriptors = @[self.sortByNameAsc];
    self.characterRaces = [self.managedObjectContext executeFetchRequest:characterRacesRequest error:nil];
    if ([self.characterRaces count] == 0) {
        [self.starterSetDataGenerator generateCharacterRaces];
    }
    
    NSFetchRequest *characterClassesRequest = [NSFetchRequest fetchRequestWithEntityName:@"CharacterClass"];
    characterClassesRequest.sortDescriptors = @[self.sortByNameAsc];
    self.characterClassesArray = [self.managedObjectContext executeFetchRequest:characterClassesRequest error:nil];
    if ([self.characterClassesArray count] == 0) {
        [self.starterSetDataGenerator generateCharacterClasses];
    }
    
    NSFetchRequest *schoolsOfMagicRequest = [NSFetchRequest fetchRequestWithEntityName:@"SchoolOfMagic"];
    schoolsOfMagicRequest.sortDescriptors = @[self.sortByNameAsc];
    self.schoolsOfMagicArray = [self.managedObjectContext executeFetchRequest:schoolsOfMagicRequest error:nil];
    if ([self.schoolsOfMagicArray count] == 0) {
        [self.starterSetDataGenerator generateSchoolsOfMagic];
    }
    
    NSMutableArray *schoolNamesMutable = [[NSMutableArray alloc]init];
    for (SchoolOfMagic *currentSchool in self.schoolsOfMagicArray) {
        [schoolNamesMutable addObject:currentSchool.name];
    }
    self.schoolsOfMagicNamesArray = [NSArray arrayWithArray:schoolNamesMutable];

    NSFetchRequest *spellLibrariesRequest = [NSFetchRequest fetchRequestWithEntityName:@"SpellLibrary"];
    spellLibrariesRequest.sortDescriptors = @[self.sortByNameAsc];
    self.spellLibrariesArray = [self.managedObjectContext executeFetchRequest:spellLibrariesRequest error:nil];
    if ([self.spellLibrariesArray count] == 0) {
        [self.starterSetDataGenerator generateStarterSetSpellLibrary];
    }
    
    NSFetchRequest *allSpellsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Spell"];
    allSpellsRequest.sortDescriptors = @[self.sortByNameAsc];
    self.allSpellsArray = [self.managedObjectContext executeFetchRequest:allSpellsRequest error:nil];
    
    NSFetchRequest *playerCharactersRequest = [NSFetchRequest fetchRequestWithEntityName:@"PlayerCharacter"];
    playerCharactersRequest.sortDescriptors = @[self.sortByCharacterNameAsc];
    self.playerCharactersArray = [self.managedObjectContext executeFetchRequest:playerCharactersRequest error:nil];
    
    if ([self.playerCharactersArray count] == 0) {
        [self generateTestData]; // remains a local method
    }
}

# pragma mark - Generate Test Data

- (void)generateTestData
{
    CharacterClass *wizard = self.characterClassesArray[3];
    SchoolOfMagic *evocation = self.schoolsOfMagicArray[4];
    CharacterRace *human = self.characterRaces[3];

    
    PlayerCharacter *merlin = [PlayerCharacter createPlayerCharacterWithContext:self.managedObjectContext
                                                                  characterName:@"Merlin"
                                                                 characterClass:wizard
                                                                  characterRace:human
                                                                          level:@2
                                                                   strengthRoll:@7
                                                                  dexterityRoll:@11
                                                               constitutionRoll:@9
                                                               intelligenceRoll:@18
                                                                     wisdomRoll:@17
                                                                   charismaRoll:@14];

    [merlin.chosenClass setSchoolOfMagic:evocation];
    SpellBook *merlinsSpellBook = [SpellBook createSpellBookWithContext:self.managedObjectContext
                                                                   name:@"Merlin's Spell Book"
                                                        playerCharacter:merlin];
    
    Spell *light = [self.allSpellsArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", @"Light"]][0];
    Spell *mageHand = [self.allSpellsArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", @"Mage Hand"]][0];
    Spell *magicMissile = [self.allSpellsArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", @"Magic Missile"]][0];
    
    NSArray *spellsToAdd = @[light, mageHand, magicMissile];
    [merlinsSpellBook addSpells:[NSSet setWithArray:spellsToAdd]];
    
    NSArray *merlinsSkills = [merlin.skills allObjects];
    Skill *investigation = [merlinsSkills filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", @"Investigation"]][0];
    [investigation toggleProficiency];
    Skill *medicine = [merlinsSkills filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", @"Medicine"]][0];
    [medicine toggleProficiency];
    
    [self saveContext];
    [self fetchData];
}

- (NSArray *)filteredAllSpellsForPlayerCharacter:(PlayerCharacter *)playerCharacter
{
    NSMutableArray *filteredSpellsByCharacterClass = [[NSMutableArray alloc]init];
    for (Spell *currentSpell in self.allSpellsArray) {
        if ([currentSpell.allowedClasses containsObject:playerCharacter.chosenClass.characterClass]) {
            [filteredSpellsByCharacterClass addObject:currentSpell];
        }
    }
    return [NSArray arrayWithArray:filteredSpellsByCharacterClass];
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Cantrip.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Cantrip" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
