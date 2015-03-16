//
//  MM_CharacterListTableViewController.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_CharacterListTableViewController.h"
#import "MM_CharacterDetailTableViewController.h"
#import "MM_SpellLibraryTableViewController.h"
#import "MM_AddCharacterViewController.h"
#import "PlayerCharacter.h"
#import "CharacterClass.h"

@interface MM_CharacterListTableViewController ()

@end

@implementation MM_CharacterListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.starterSetDataManager fetchData];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.starterSetDataManager.playerCharactersArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playerCharacterCell" forIndexPath:indexPath];
    
    PlayerCharacter *currentPlayerCharacter = self.starterSetDataManager.playerCharactersArray[indexPath.row];
    
    cell.textLabel.text = currentPlayerCharacter.characterName;
    
    NSString *detailText = [NSString stringWithFormat:@"  %@", currentPlayerCharacter.characterClass.name];
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
        MM_CharacterDetailTableViewController *characterDTVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        characterDTVC.playerCharacter = self.starterSetDataManager.playerCharactersArray[indexPath.row];
    }
    else if ([segue.identifier isEqualToString:@"segueToAddCharacter"]) {
        // defined in MAIN.Storyboard
    }
    else {
        MM_SpellLibraryTableViewController *spellLibraryTVC = segue.destinationViewController;
        spellLibraryTVC.spellLibrary = self.starterSetDataManager.spellLibrariesArray[0]; //only displays the first library, for now
        spellLibraryTVC.navigationItem.title = @"All Spells";
    }
}

@end
