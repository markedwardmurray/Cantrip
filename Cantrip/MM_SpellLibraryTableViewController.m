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
#import "SchoolOfMagic.h"
#import "SpellLibrary.h"
#import "SpellBook.h"
#import "Spell.h"

@interface MM_SpellLibraryTableViewController ()

@property (strong, nonatomic) NSArray *spellsArray;

@end

@implementation MM_SpellLibraryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
    if (self.relevantSpellBook != nil) {
        PlayerCharacter *relevantPlayerCharacter = self.relevantSpellBook.playerCharacter;
        self.spellsArray = [self.starterSetDataManager filteredAllSpellsForPlayerCharacter:relevantPlayerCharacter];
        self.navigationItem.title = [NSString stringWithFormat:@"Spells %@ Can Learn", relevantPlayerCharacter.characterName];
    }
    else {
        self.spellsArray = [self.spellLibrary.spells allObjects];
        self.navigationItem.title = @"All Spells";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.spellsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"spellCell" forIndexPath:indexPath];
    Spell *currentSpell = self.spellsArray[indexPath.row];
    cell.textLabel.text = currentSpell.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Level %@ %@ spell", currentSpell.level, currentSpell.schoolOfMagic.name];
    
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
    MM_SpellDetailTableViewController *spellDTVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Spell *selectedSpell = self.spellsArray[indexPath.row];
    spellDTVC.spell = selectedSpell;
    spellDTVC.navigationItem.title = selectedSpell.name;
    spellDTVC.navigationItem.prompt = self.navigationItem.title;
    spellDTVC.relevantSpellBook = self.relevantSpellBook;
}


@end
