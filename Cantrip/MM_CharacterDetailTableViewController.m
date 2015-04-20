//
//  MM_CharacterDetailTableViewController.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_CharacterDetailTableViewController.h"

// View Controllers
#import "MM_SpellBookTableViewController.h"
#import "MM_CreateSpellBookViewController.h"

// Data Managers
#import "MM_StarterSetDataManager.h"
#import "MM_CharacterDetailDataManager.h"

// Core Data Models
#import "PlayerCharacter.h"
#import "CharacterRace.h"
#import "SchoolOfMagic.h"
#import "CharacterClass.h"
#import "ChosenClass.h"
#import "SpellBook.h"
#import "AbilityScore.h"
#import "Skill.h"

@interface MM_CharacterDetailTableViewController ()

@property (strong, nonatomic) MM_CharacterDetailDataManager *characterDetailDataManager;
@property (strong, nonatomic) NSMutableArray *displayData;
@property (strong, nonatomic) NSMutableArray *sectionHeaders;

@end

@implementation MM_CharacterDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
    self.characterDetailDataManager = [[MM_CharacterDetailDataManager alloc]initWithPlayerCharacter:self.playerCharacter];
    self.navigationItem.title = self.playerCharacter.characterName;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self organizeDisplayDataAndSectionHeaders];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)organizeDisplayDataAndSectionHeaders {
    [self.characterDetailDataManager organizeDisplayDataAndSectionHeaders];
    self.displayData = self.characterDetailDataManager.displayData;
    self.sectionHeaders = self.characterDetailDataManager.sectionHeaders;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.displayData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.displayData[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionHeaders[section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"characterBriefCell" forIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"abilityScoreCell" forIndexPath:indexPath];
    } else if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"skillCell" forIndexPath:indexPath];
    } else if (indexPath.section == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"spellBookCell" forIndexPath:indexPath];
    }
    NSArray *currentData = self.displayData[indexPath.section][indexPath.row];
    cell.textLabel.text = currentData[0];
    cell.detailTextLabel.text = currentData[1];
    
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
        MM_SpellBookTableViewController *spellBookTVC = segue.destinationViewController;
        spellBookTVC.spellBook = self.playerCharacter.spellBook;
    }
    else {
        MM_CreateSpellBookViewController *createSpellBookVC = segue.destinationViewController;
        createSpellBookVC.playerCharacter = self.playerCharacter;
    }
}

@end
