//
//  MM_StarterSetDataManager.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_StarterSetDataManager.h"
#import "PlayerCharacter.h"
#import "PlayerCharacter+Methods.h"
#import "CharacterClass.h"
#import "CharacterClass+Methods.h"
#import "Spell.h"
#import "Spell+Methods.h"
#import "SpellBook.h"
#import "SpellBook+Methods.h"
#import "SchoolOfMagic.h"
#import "SchoolOfMagic+Methods.h"
#import "SpellLibrary.h"
#import "SpellLibrary+Methods.h"

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

- (void)fetchData
{
    NSFetchRequest *playerCharactersRequest = [NSFetchRequest fetchRequestWithEntityName:@"PlayerCharacter"];
    NSSortDescriptor *characterNameSorter = [NSSortDescriptor sortDescriptorWithKey:@"characterName" ascending:YES];
    playerCharactersRequest.sortDescriptors = @[characterNameSorter];
    self.playerCharactersArray = [self.managedObjectContext executeFetchRequest:playerCharactersRequest error:nil];
    
    NSFetchRequest *spellLibrariesRequest = [NSFetchRequest fetchRequestWithEntityName:@"SpellLibrary"];
    NSSortDescriptor *nameSorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    spellLibrariesRequest.sortDescriptors = @[nameSorter];
    self.spellLibrariesArray = [self.managedObjectContext executeFetchRequest:spellLibrariesRequest error:nil];
    
    NSFetchRequest *characterClassesRequest = [NSFetchRequest fetchRequestWithEntityName:@"CharacterClass"];
    //nameSorter defined above
    characterClassesRequest.sortDescriptors = @[nameSorter];
    self.characterClassesArray = [self.managedObjectContext executeFetchRequest:characterClassesRequest error:nil];
    
    NSFetchRequest *schoolsOfMagicRequest = [NSFetchRequest fetchRequestWithEntityName:@"SchoolOfMagic"];
    //nameSorter defined above
    schoolsOfMagicRequest.sortDescriptors = @[nameSorter];
    self.schoolsOfMagicArray = [self.managedObjectContext executeFetchRequest:schoolsOfMagicRequest error:nil];
    
    NSFetchRequest *allSpellsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Spell"];
    //nameSorter defined above
    allSpellsRequest.sortDescriptors = @[nameSorter];
    self.allSpellsArray = [self.managedObjectContext executeFetchRequest:allSpellsRequest error:nil];
    
    
    if ([self.characterClassesArray count] == 0) {
        [self generateCharacterClasses];
    }
    
    if ([self.schoolsOfMagicArray count] == 0) {
        [self generateSchoolsOfMagic];
    }
    
    if ([self.spellLibrariesArray count] == 0) {
        [self generateStarterSetSpellLibrary];
    }
    
    if ([self.playerCharactersArray count] == 0) {
        [self generateTestData];
    }
}

# pragma mark - Generate Data

- (void)generateCharacterClasses
{
    CharacterClass *cleric = [CharacterClass createCharacterClassWithContext:self.managedObjectContext
                                                                        name:@"Cleric"];
    CharacterClass *wizard = [CharacterClass createCharacterClassWithContext:self.managedObjectContext
                                                                        name:@"Wizard"];
    self.characterClassesArray = @[cleric, wizard];
    
    [self saveContext];
    [self fetchData];
}

- (void)generateSchoolsOfMagic
{
    SchoolOfMagic *abjuration = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                         name:@"Abjuration"];
    SchoolOfMagic *conjuration = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                          name:@"Conjuration"];
    SchoolOfMagic *divination = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                         name:@"Divination"];
    SchoolOfMagic *enchantment = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                          name:@"Enchantment"];
    SchoolOfMagic *evocation = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                        name:@"Evocation"];
    SchoolOfMagic *illusion = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                       name:@"Illusion"];
    SchoolOfMagic *necromancy = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                        name:@"Necromancy"];
    SchoolOfMagic *transmutation = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                            name:@"Transmutation"];
    self.schoolsOfMagicArray = @[abjuration, conjuration, divination, enchantment,
                                 evocation, illusion, necromancy, transmutation];
    
    [self saveContext];
    [self fetchData];
}
# pragma mark - Generate Spell Library

- (void)generateStarterSetSpellLibrary
{
    SpellLibrary *starterSetSpellLibrary = [SpellLibrary createSpellLibraryWithContext:self.managedObjectContext
                                                                                  name:@"D&D 5e Starter Set Spells"];
    
    CharacterClass *cleric = self.characterClassesArray[0];
    CharacterClass *wizard = self.characterClassesArray[1];
    
    SchoolOfMagic *abjuration = self.schoolsOfMagicArray[0];
    SchoolOfMagic *conjuration = self.schoolsOfMagicArray[1];
    SchoolOfMagic *divination = self.schoolsOfMagicArray[2];
    SchoolOfMagic *enchantment = self.schoolsOfMagicArray[3];
    SchoolOfMagic *evocation = self.schoolsOfMagicArray[4];
    SchoolOfMagic *illusion = self.schoolsOfMagicArray[5];
    SchoolOfMagic *necromany = self.schoolsOfMagicArray[6];
    SchoolOfMagic *transmutation = self.schoolsOfMagicArray[7];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Acid Splash"
                            level:@0
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"You hurl a bubble of acid. Choose one creature within range, or choose two creatures within range that are within 5 feet of each other. A target must succeed on a Dexterity saving throw or take 1d6 acid damage.\n    This spell’s damage increases by 1d6 when you reach 5th level (2d6), 11th level (3d6), and 17th level (4d6)."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Bless"
                            level:@1
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, S, M (a sprinkling of holy water)"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"You bless up to three creatures of your choice within range. Whenever a target makes an attack roll or a saving throw before the spell ends, the target can roll a d4 and add the number rolled to the attack roll or saving throw.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, you can target one additional creature for each slot level above 1st."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Burning Hands"
                            level:@1
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self (15-foot cone)"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"As you hold your hands with thumbs touching and fingers spread, a thin sheet of flames shoots forth from your outstretched fingertips. Each creature in a 15-foot cone must make a Dexterity saving throw. A creature takes 3d6 fire damage on a failed save, or half as much damage on a successful one.\n    The fire ignites any flammable objects in the area that aren’t being worn or carried.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d6 for each slot level above 1st."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Charm Person"
                            level:@1
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, S"
                         duration:@"1 hour"
                 spellDescription:@"You attempt to charm a humanoid you can see within range. It must make a Wisdom saving throw, and does so with advantage if you or your companions are fighting it. If it fails the saving throw, it is charmed by you until the spell ends or until you or your companions do anything harmful to it. The charmed creature regards you as a friendly acquaintance. When the spell ends, the creature knows it was charmed by you.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, you can target one additional creature for each slot level above 1st. The creatures must be within 30 feet of each other when you target them."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Command"
                            level:@1
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V"
                         duration:@"1 round"
                 spellDescription:@"You speak a one-word command to a creature you can see within range. The target must succeed on a Wisdom saving throw or follow the command on its next turn. The spell has no effect if the target is undead, if it doesn’t understand your language, or if your command is directly harmful to it.\n    Some typical commands and their effects follow. You might issue a command other than one described here. If you do so, the DM determines how the target behaves. If the target can’t follow your command, the spell ends.\n    Approach. The target moves toward you by the shortest and most direct route, ending its turn if it moves within 5 feet of you.\n    Drop. The target drops whatever it is holding and then ends its turn.\n    Flee. The target spends its turn moving away from you by the fastest available means.\n    Grovel. The target falls prone and then ends its turn.\n    Halt. The target doesn’t move and takes no actions. A flying creature stays aloft, provided that it is able to do so. If it must move to stay aloft, it flies the minimum distance needed to remain in the air.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, you can affect one additional creature for each slot level above 1st. The creatures must be within 30 feet of each other when you target them."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Comprehend Languages (ritual)"
                            level:@1
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S, M (a pinch of soot and salt)"
                         duration:@"1 hour"
                 spellDescription:@"For the duration, you understand the literal meaning of any spoken language that you hear. You also understand any written language that you see, but you must be touching the surface on which the words are written. It takes about 1 minute to read one page of text.\n    This spell doesn’t decode secret messages in a text or a glyph, such as an arcane sigil, that isn’t part of a written language."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Cure Wounds"
                            level:@1
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"A creature you touch regains a number of hit points equal to 1d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, the healing increases by 1d8 for each slot level above 1st."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Dancing Lights"
                            level:@0
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"120 feet"
                       components:@"V, S, M (a bit of phosphorus or wychwood, or a glowworm)"
                         duration:@"Concentraion, up to 1 minute"
                 spellDescription:@"You create up to four torch-sized lights within range, making them appear as torches, lanterns, or glowing orbs that hover in the air for the duration. You can also combine the four lights into one glowing vaguely humanoid form of Medium size. Whichever form you choose, each light sheds dim light in a 10-foot radius.\n    As a bonus action on your turn, you can move the lights up to 60 feet to a new spot within range. A light must be within 20 feet of another light created by this spell, and a light winks out if it exceeds the spell’s range."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Detect Magic (ritual)"
                            level:@1
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric, wizard]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S"
                         duration:@"Concentraion, up to 10 minutes"
                 spellDescription:@"For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any.\n    The spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Disguise Self"
                            level:@1
                    schoolOfMagic:illusion
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S"
                         duration:@"1 hour"
                 spellDescription:@"You make yourself—including your clothing, armor, weapons, and other belongings on your person—look different until the spell ends or until you use your action to dismiss it. You can seem 1 foot shorter or taller and can appear thin, fat, or in between. You can’t change your body type, so you must adopt a form that has the same basic arrangement of limbs. Otherwise, the extent of the illusion is up to you.\n    The changes wrought by this spell fail to hold up to physical inspection. For example, if you use this spell to add a hat to your outfit, objects pass through the hat, and anyone who touches it would feel nothing or would feel your head and hair. If you use this spell to appear thinner than you are, the hand of someone who reaches out to touch you would bump into you while it was seemingly still in midair.\n    To discern that you are disguised, a creature can use its action to inspect your appearance and must succeed on an Intelligence (Investigation) check against your spell save DC."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Light"
                            level:@0
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric, wizard]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, M (a firely or phosphorescent moss)"
                         duration:@"1 hour"
                 spellDescription:@"You touch one object that is no larger than 10 feet in any dimension. Until the spell ends, the object sheds bright light in a 20-foot radius and dim light for an additional 20 feet. The light can be colored as you like. Completely covering the object with something opaque blocks the light. The spell ends if you cast it again or dismiss it as an action.\n    If you target an object held or worn by a hostile creature, that creature must succeed on a Dexterity saving throw to avoid the spell."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Mage Hand"
                            level:@0
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, S"
                         duration:@"1 minute"
                 spellDescription:@"A spectral, floating hand appears at a point you choose within range. The hand lasts for the duration or until you dismiss it as an action. The hand vanishes if it is ever more than 30 feet away from you or if you cast this spell again.\n    You can use your action to control the hand. You can use the hand to manipulate an object, open an unlocked door or container, stow or retrieve an item from an open container, or pour the contents out of a vial. You can move the hand up to 30 feet each time you use it.\n    The hand can’t attack, activate magic items, or carry more than 10 pounds."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Magic Missile"
                            level:@1
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"120 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"You create three glowing darts of magical force. Each dart hits a creature of your choice that you can see within range. A dart deals 1d4 + 1 force damage to its target. The darts all strike simultaneously, and you can direct them to hit one creature or several.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, the spell creates one more dart for each slot level above 1st."];
    
    [self saveContext];
    [self fetchData];
}

# pragma mark - Generate Test Data

- (void)generateTestData
{
    CharacterClass *wizard = self.characterClassesArray[1];
    SchoolOfMagic *evocation = self.schoolsOfMagicArray[4];
    
    PlayerCharacter *merlin = [PlayerCharacter createPlayerCharacterWithContext:self.managedObjectContext
                                                                  characterName:@"Merlin"
                                                                 characterClass:wizard];
    [merlin setSchoolOfMagic:evocation];
    SpellBook *merlinsSpellBook = [SpellBook createSpellBookWithContext:self.managedObjectContext
                                                                   name:@"Merlin's Spell Book"
                                                        playerCharacter:merlin];
    
    Spell *light = [self.allSpellsArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", @"Light"]][0];
    Spell *mageHand = [self.allSpellsArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", @"Mage Hand"]][0];
    Spell *magicMissile = [self.allSpellsArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.name == %@", @"Magic Missile"]][0];
    
    NSArray *spellsToAdd = @[light, mageHand, magicMissile];
    [merlinsSpellBook addSpells:[NSSet setWithArray:spellsToAdd]];
    
    [self saveContext];
    [self fetchData];
}

- (NSArray *)filteredAllSpellsForPlayerCharacter:(PlayerCharacter *)playerCharacter
{
    NSMutableArray *filteredSpellsByCharacterClass = [[NSMutableArray alloc]init];
    for (Spell *currentSpell in self.allSpellsArray) {
        if ([currentSpell.allowedClasses containsObject:playerCharacter.characterClass]) {
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
