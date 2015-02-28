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

@end

@implementation MM_SpellBookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
    self.spellsArray = [self.spellBook.spells allObjects];
    self.navigationItem.title = self.spellBook.name;
    self.navigationItem.prompt = self.spellBook.playerCharacter.characterName;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.spellsArray = [self.spellBook.spells allObjects];
    [self.tableView reloadData];
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
    NSString *detailText = [NSString stringWithFormat:@"Level %@ %@ spell", currentSpell.level, currentSpell.schoolOfMagic.name];
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
        Spell *selectedSpell = self.spellsArray[indexPath.row];
        spellDTVC.spell = selectedSpell;
        spellDTVC.navigationItem.title = selectedSpell.name;
        NSString *newPrompt = [NSString stringWithFormat:@"%@ - %@", self.navigationItem.prompt, self.navigationItem.title];
        spellDTVC.navigationItem.prompt = newPrompt;
    }
    else {
        MM_SpellLibraryTableViewController *spellLibraryTVC = segue.destinationViewController;
        spellLibraryTVC.spellLibrary = self.starterSetDataManager.spellLibrariesArray[0];
        spellLibraryTVC.relevantSpellBook = self.spellBook;
    }
}


@end
