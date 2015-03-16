//
//  MM_SpellBookTableViewController.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_SpellBookTableViewController.h"
#import "MM_SpellDetailTableViewController.h"
#import "MM_SpellLibraryTableViewController.h"
#import "MM_StarterSetDataManager.h"
#import "SpellBook.h"
#import "Spell.h"
#import "SchoolOfMagic.h"
#import "PlayerCharacter.h"

@interface MM_SpellBookTableViewController ()

@property (strong, nonatomic) NSArray *spellsBySection;
@property (strong, nonatomic) NSMutableArray *sectionIndexTitles;

@end

@implementation MM_SpellBookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
    self.sectionIndexTitles = [[NSMutableArray alloc]init];
    
    self.navigationItem.title = self.spellBook.name;
    self.navigationItem.prompt = self.spellBook.playerCharacter.characterName;
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

- (NSArray *)predicateAllSpellsByLevelInt:(NSInteger )levelInt
{
    NSNumber *level = @(levelInt);
    NSPredicate *currentPredicate = [NSPredicate predicateWithFormat:@"SELF.level == %@", level];
    NSArray *predicatedSpells = [self.spellsArray filteredArrayUsingPredicate:currentPredicate];
    return predicatedSpells;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.spellsArray = [self.spellBook.spells allObjects];
    [self organizeSpellsByLevelIntoSectionsArray];
    [self.sectionIndexTitles removeAllObjects];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.spellsBySection count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.spellsBySection[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (![self.spellsBySection[section] isEqual:@[]]) {
        [self.sectionIndexTitles addObject:[NSString stringWithFormat:@"%li",section]];
        if (section == 0) {
            return @"Cantrips";
        } else {
            return [NSString stringWithFormat:@"Level %li Spells", section];
        }
    }
    return nil;
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

- (UITableViewCell *)tableView:(UITableView *)tableView
                                        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"spellCell" forIndexPath:indexPath];
    NSArray *currentSpellSection = self.spellsBySection[indexPath.section];
    Spell *currentSpell = currentSpellSection[indexPath.row];
    cell.textLabel.text = currentSpell.name;
    NSString *detailText = [NSString stringWithFormat:@"  Level %@ %@ spell", currentSpell.level, currentSpell.schoolOfMagic.name];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        MM_SpellDetailTableViewController *spellDTVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *selectedSpellSection = self.spellsBySection[indexPath.section];
        Spell *selectedSpell = selectedSpellSection[indexPath.row];
        spellDTVC.spell = selectedSpell;
        spellDTVC.navigationItem.title = selectedSpell.name;
        NSString *newPrompt = [NSString stringWithFormat:@"%@ - %@", self.navigationItem.prompt, self.navigationItem.title];
        spellDTVC.navigationItem.prompt = newPrompt;
    }
    else {
        MM_SpellLibraryTableViewController *spellLibraryTVC = segue.destinationViewController;
        spellLibraryTVC.spellLibrary = self.starterSetDataManager.spellLibrariesArray[0];
        spellLibraryTVC.relevantSpellBook = self.spellBook;
        spellLibraryTVC.navigationItem.title = @"Available Spells";
        spellLibraryTVC.navigationItem.prompt = self.spellBook.name;
    }
}


@end
