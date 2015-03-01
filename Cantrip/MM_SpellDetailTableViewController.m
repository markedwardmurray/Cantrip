//
//  MM_SpellDetailTableViewController.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_SpellDetailTableViewController.h"
#import "MM_AddSpellToSpellBookTableViewController.h"
#import "MM_StarterSetDataManager.h"
#import "Spell.h"
#import "SpellBook.h"
#import "SchoolOfMagic.h"

@interface MM_SpellDetailTableViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) NSArray *titlesArray;
@property (strong, nonatomic) NSArray *detailTextArray;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addSpellButton;
- (IBAction)addTapped:(id)sender;

@end

@implementation MM_SpellDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
    self.titlesArray = @[@"Casting Time", @"Range", @"Components", @"Duration"];
    self.detailTextArray = @[self.spell.castingTime, self.spell.range, self.spell.components, self.spell.duration];
    if (self.relevantSpellBook == nil) {
        self.addSpellButton.enabled = NO;
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
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"subtitleCell" forIndexPath:indexPath];
        cell.textLabel.text = self.spell.name;
        NSString *detailText = [NSString stringWithFormat:@"Level %@ %@ spell", self.spell.level, self.spell.schoolOfMagic.name];
        cell.detailTextLabel.text = detailText;
    }
    else if (indexPath.row >= 1 && indexPath.row <= 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"leftDetailCell" forIndexPath:indexPath];
        cell.textLabel.text = self.titlesArray[indexPath.row - 1];
        cell.detailTextLabel.text = self.detailTextArray[indexPath.row - 1];
    }
    else if (indexPath.row == 5) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
        cell.textLabel.text = self.spell.spellDescription;
    }
    
    // Configure the cell...
    
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
    MM_AddSpellToSpellBookTableViewController *addSpellToSpellBookTVC = segue.destinationViewController;
    addSpellToSpellBookTVC.selectedSpell = self.spell;
    
}

- (void)removeSpellTapped:(id)sender {
        
}
    
- (IBAction)addTapped:(id)sender {
    if (![self.relevantSpellBook.spells containsObject:self.spell]) {
        NSString *alertMessage =
                [NSString stringWithFormat:@"Do you wish to add the spell %@ to %@?",
                                    self.spell.name, self.relevantSpellBook.name];
        UIAlertView *reallyAddSpellAlert =
                [[UIAlertView alloc]initWithTitle:@"Add Spell to Spell Book?"
                                        message:alertMessage
                                         delegate:self
                                cancelButtonTitle:@"NO"
                                otherButtonTitles:@"YES", nil];
        [reallyAddSpellAlert show];

        [self.relevantSpellBook addSpellsObject:self.spell];
        [self.starterSetDataManager saveContext];
    }
    else {
        NSString *duplicateSpellAlertMessage =
                [NSString stringWithFormat:@"%@ already contains the spell %@",
                                self.relevantSpellBook.name, self.spell.name];
        UIAlertView *duplicateSpellAlert =
                [[UIAlertView alloc]initWithTitle:@"Duplicate Spell!"
                                          message:duplicateSpellAlertMessage
                                         delegate:self
                                cancelButtonTitle:@"OK!"
                                otherButtonTitles:nil];
        [duplicateSpellAlert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"Add Spell to Spell Book?"]) {
        NSString *alertMessage = [NSString stringWithFormat:@"The spell %@ has been added to %@", self.spell.name, self.relevantSpellBook.name];
        UIAlertView *spellAddedAlert =
                [[UIAlertView alloc]initWithTitle:@"Spell Added!"
                                          message:alertMessage
                                         delegate:self
                                cancelButtonTitle:@"OK!"
                                otherButtonTitles:nil];
        
        switch (buttonIndex) {
            case 0:
                // cancel, no action
                break;
            case 1:
                [self.relevantSpellBook addSpellsObject:self.spell];
                [self.starterSetDataManager saveContext];
                [spellAddedAlert show];
                break;
                
            default:
                break;
        }
    [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
