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
#import "SchoolOfMagic.h"
#import "SpellLibrary.h"
#import "SpellBook.h"
#import "Spell.h"

@interface MM_SpellLibraryTableViewController ()

@property (strong, nonatomic) NSMutableArray *spellsArray;
@property (strong, nonatomic) NSArray *spellsBySection;
@property (strong, nonatomic) NSMutableArray *sectionIndexTitles;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedSortSelector;
- (IBAction)refreshTapped:(id)sender;

@end

@implementation MM_SpellLibraryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.sectionIndexTitles == nil) {
        self.sectionIndexTitles = [[NSMutableArray alloc]init];
    }
    [self filterSpellsArray];
    [self organizeSpellsByLevelIntoSectionsArray];
    [self.sectionIndexTitles removeAllObjects];
    [self.tableView reloadData];
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
    NSSortDescriptor *sortByAsc = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *sortedIndexTitles = [self.sectionIndexTitles sortedArrayUsingDescriptors:@[sortByAsc]];
    self.sectionIndexTitles = [sortedIndexTitles mutableCopy];
    if ([[self.sectionIndexTitles firstObject] isEqualToString:@"0"]) {
        [self.sectionIndexTitles replaceObjectAtIndex:0 withObject:@"C"];
    }
    return self.sectionIndexTitles;
}

-(NSInteger)tableView:(UITableView *)tableView
                                        sectionForSectionIndexTitle:(NSString *)title
                                                            atIndex:(NSInteger)index {
    return [self.sectionIndexTitles indexOfObject:title];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *letterForSection;
    switch ([self.segmentedSortSelector selectedSegmentIndex]) {
        case 0:
            if (![self.spellsBySection[section] isEqual:@[]]) {
                [self.sectionIndexTitles addObject:[NSString stringWithFormat:@"%li", section]];
                if (section == 0) {
                    return @"Cantrips";
                } else {
                    return [NSString stringWithFormat:@"Level %li Spells", section];
                }
            } else {
                return nil;
            }
            break;
        case 1:
            // not yet defined
            break;
        case 2:
            letterForSection = self.sectionIndexTitles[section];
            return letterForSection;
        default:
            return nil;
            break;
    }
    return nil;
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

#pragma mark - Segmented Control Refresh

- (IBAction)refreshTapped:(id)sender {
    [self.sectionIndexTitles removeAllObjects];
    NSInteger selectedSegmentInt = [self.segmentedSortSelector selectedSegmentIndex];
    if (selectedSegmentInt == 0) {
        [self organizeSpellsByLevelIntoSectionsArray];
        NSLog(@"sort by level");
    }
    else if (selectedSegmentInt == 1) {
        NSLog(@"sort by school");
    }
    else if (selectedSegmentInt == 2) {
        [self organizeSpellsByNameIntoSectionsArray];
        NSLog(@"sort by name");
    }
    [self.tableView reloadData];
}

- (void)organizeSpellsByLevelIntoSectionsArray
{
    NSMutableArray *spellsByLevel = [[NSMutableArray alloc]init];
    NSSortDescriptor *sortByNameAsc = self.starterSetDataManager.sortByNameAsc;
    
    for (NSInteger i=0; i<=9; i++) {
        NSArray *spellsOfCurrentLevel = [self predicateAllSpellsByLevelInt:i];
        NSArray *spellsOfCurrentLevelByName = [spellsOfCurrentLevel sortedArrayUsingDescriptors:@[sortByNameAsc]];
        [spellsByLevel addObject:spellsOfCurrentLevelByName];
    }
    self.spellsBySection = [NSArray arrayWithArray:spellsByLevel];
}

- (NSArray *)predicateAllSpellsByLevelInt:(NSInteger)levelInt
{
    NSNumber *level = @(levelInt);
    NSPredicate *currentPredicate = [NSPredicate predicateWithFormat:@"SELF.level == %@", level];
    NSArray *predicatedSpells = [self.spellsArray filteredArrayUsingPredicate:currentPredicate];
    return predicatedSpells;
}

- (void)organizeSpellsByNameIntoSectionsArray {
    NSMutableArray *spellsByName = [[NSMutableArray alloc]init];
    NSSortDescriptor *sortByNameAsc = self.starterSetDataManager.sortByNameAsc;
    NSSortDescriptor *sortByLevelAsc = self.starterSetDataManager.sortByLevelAsc;
    NSArray *alphabetArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    for (NSString *currentLetter in alphabetArray) {
        NSArray *spellsOfCurrentLetter = [self predicateAllSpellsByNameWithFirstLetter:currentLetter];
        NSArray *spellsOfCurrentLetterByNameByLevel = [spellsOfCurrentLetter sortedArrayUsingDescriptors:@[sortByNameAsc, sortByLevelAsc]];
        if (![spellsOfCurrentLetterByNameByLevel isEqual:@[]]) {
            [self.sectionIndexTitles addObject:currentLetter];
            [spellsByName addObject:spellsOfCurrentLetterByNameByLevel];
        }
    }
    self.spellsBySection = [NSArray arrayWithArray:spellsByName];
}

- (NSArray *)predicateAllSpellsByNameWithFirstLetter:(NSString *)letter {
    NSPredicate *letterPredicate = [NSPredicate predicateWithFormat:@"SELF.name BEGINSWITH %@", letter];
    NSArray *predicatedSpells = [self.spellsArray filteredArrayUsingPredicate:letterPredicate];
    return predicatedSpells;
}

@end
