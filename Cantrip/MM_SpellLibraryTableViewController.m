//
//  MM_SpellLibraryTableViewController.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_SpellLibraryTableViewController.h"
#import "MM_SpellDetailTableViewController.h"
#import "MM_StarterSetDataManager.h"
#import "PlayerCharacter.h"
#import "CharacterClass.h"
#import "ChosenClass.h"
#import "SchoolOfMagic.h"
#import "SpellLibrary.h"
#import "SpellBook.h"
#import "Spell.h"

@interface MM_SpellLibraryTableViewController ()

@property (strong, nonatomic) NSMutableArray *spellsArray;
@property (strong, nonatomic) NSArray *spellsBySection;
@property (strong, nonatomic) NSMutableArray *sectionIndexTitles;
@property (strong, nonatomic) NSMutableArray *sectionHeaderTitles;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedSortSelector;

@end

@implementation MM_SpellLibraryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
    
    if (self.sectionIndexTitles == nil) {
        self.sectionIndexTitles = [[NSMutableArray alloc]init];
    }
    if (self.sectionHeaderTitles == nil) {
        self.sectionHeaderTitles = [[NSMutableArray alloc]init];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self filterSpellsArray];
    [self segmentChangeAction:self];
}

- (void)filterSpellsArray
{
    if (self.relevantSpellBook != nil) {
        PlayerCharacter *relevantPlayerCharacter = self.relevantSpellBook.playerCharacter;
        self.spellsArray = [NSMutableArray arrayWithArray:[self.starterSetDataManager filteredAllSpellsForPlayerCharacter:relevantPlayerCharacter]];
        for (Spell *knownSpell in self.relevantSpellBook.spells) {
            if ([self.spellsArray containsObject:knownSpell]) {
                [self.spellsArray removeObject:knownSpell];
            }
        }
    }
    else {
        self.spellsArray = [NSMutableArray arrayWithArray:[self.spellLibrary.spells allObjects]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.spellsBySection count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.spellsBySection[section] count];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitles;
}

-(NSInteger)tableView:(UITableView *)tableView
                                        sectionForSectionIndexTitle:(NSString *)title
                                                            atIndex:(NSInteger)index {
    return [self.sectionIndexTitles indexOfObject:title];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.sectionHeaderTitles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"spellCell" forIndexPath:indexPath];
    NSArray *currentSpellSection = self.spellsBySection[indexPath.section];
    Spell *currentSpell = currentSpellSection[indexPath.row];
    cell.textLabel.text = currentSpell.name;
    NSMutableString *detailText = [NSMutableString stringWithFormat:@"  Level %@ %@ spell\n  Allowed classes:", currentSpell.level, currentSpell.schoolOfMagic.name];
    for (CharacterClass *allowedClass in currentSpell.allowedClasses) {
        [detailText appendFormat:@"  %@", allowedClass.name];
    }
    cell.detailTextLabel.text = detailText;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Segmented Control Refresh

- (IBAction)segmentChangeAction:(id)sender {
    [self.sectionHeaderTitles removeAllObjects];
    [self.sectionIndexTitles removeAllObjects];
    NSInteger selectedSegmentInt = [self.segmentedSortSelector selectedSegmentIndex];
    if (selectedSegmentInt == 0) {
        [self organizeSpellsByLevelIntoSectionsArray];
    }
    else if (selectedSegmentInt == 1) {
        [self organizeSpellsBySchoolNameIntoSectionsArray];
    }
    else if (selectedSegmentInt == 2) {
        [self organizeSpellsByNameIntoSectionsArray];
    }
    else {
        NSLog(@"Segmented Control Error");
    }
    [self.tableView reloadData];
}

- (void)organizeSpellsByLevelIntoSectionsArray
{
    NSMutableArray *spellsByLevel = [[NSMutableArray alloc]init];
    
    for (NSInteger i=0; i<=9; i++) {
        NSPredicate *levelPredicate = [NSPredicate predicateWithFormat:@"SELF.level == %li", i];
        NSArray *spellsOfCurrentLevel = [self.spellsArray filteredArrayUsingPredicate:levelPredicate];
        NSArray *spellsOfCurrentLevelByName = [spellsOfCurrentLevel
                sortedArrayUsingDescriptors:@[self.starterSetDataManager.sortByNameAsc]];
        
        if (![spellsOfCurrentLevelByName isEqual:@[]]) {
            NSString *sectionHeaderString;
            NSString *sectionIndexString;
            
            if (i == 0) {
                sectionHeaderString = @"Cantrips";
                sectionIndexString = @"C";
            } else {
                sectionHeaderString = [NSString stringWithFormat:@"Level %li Spells", i];
                sectionIndexString = [NSString stringWithFormat:@"%li", i];
            }
            [self.sectionHeaderTitles addObject:sectionHeaderString];
            [self.sectionIndexTitles addObject:sectionIndexString];
            [spellsByLevel addObject:spellsOfCurrentLevelByName];
        }
    }
    self.spellsBySection = [NSArray arrayWithArray:spellsByLevel];
}

- (void)organizeSpellsBySchoolNameIntoSectionsArray {
    NSMutableArray *spellsBySchoolName = [[NSMutableArray alloc]init];
    NSArray *schoolsOfMagicNames = self.starterSetDataManager.schoolsOfMagicNamesArray;
    
    for (NSString *schoolName in schoolsOfMagicNames) {
        NSPredicate *schoolNamePredicate = [NSPredicate predicateWithFormat:@"SELF.schoolName CONTAINS[cd] %@", schoolName];
        NSArray *spellsOfCurrentSchoolName = [self.spellsArray filteredArrayUsingPredicate:schoolNamePredicate];
        NSArray *spellsOfCurrentSchoolNameByLevelByName = [spellsOfCurrentSchoolName
                sortedArrayUsingDescriptors:@[self.starterSetDataManager.sortByLevelAsc,
                                              self.starterSetDataManager.sortByNameAsc]];
        
        if (![spellsOfCurrentSchoolNameByLevelByName isEqual:@[]]) {
            [self.sectionHeaderTitles addObject:schoolName];
            NSString *schoolTicker = [schoolName substringToIndex:3];
            [self.sectionIndexTitles addObject:schoolTicker];
            [spellsBySchoolName addObject:spellsOfCurrentSchoolNameByLevelByName];
        }
    }
    self.spellsBySection = [NSArray arrayWithArray:spellsBySchoolName];
}

- (void)organizeSpellsByNameIntoSectionsArray {
    NSMutableArray *spellsByName = [[NSMutableArray alloc]init];
    NSArray *alphabetArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I",
                               @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R",
                               @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
    for (NSString *currentLetter in alphabetArray) {
        NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"SELF.name BEGINSWITH %@", currentLetter];
        NSArray *spellsOfCurrentLetter = [self.spellsArray filteredArrayUsingPredicate:namePredicate];
        NSArray *spellsOfCurrentLetterByNameByLevel = [spellsOfCurrentLetter
                sortedArrayUsingDescriptors:@[self.starterSetDataManager.sortByNameAsc,
                                              self.starterSetDataManager.sortByLevelAsc]];
        
        if (![spellsOfCurrentLetterByNameByLevel isEqual:@[]]) {
            [self.sectionHeaderTitles addObject:currentLetter];
            [self.sectionIndexTitles addObject:currentLetter];
            [spellsByName addObject:spellsOfCurrentLetterByNameByLevel];
        }
    }
    self.spellsBySection = [NSArray arrayWithArray:spellsByName];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MM_SpellDetailTableViewController *spellDTVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSArray *selectedSpellSection = self.spellsBySection[indexPath.section];
    Spell *selectedSpell = selectedSpellSection[indexPath.row];
    spellDTVC.spell = selectedSpell;
    spellDTVC.navigationItem.title = selectedSpell.name;
    spellDTVC.navigationItem.prompt = self.navigationItem.title;
    spellDTVC.relevantSpellBook = self.relevantSpellBook;
}

@end
