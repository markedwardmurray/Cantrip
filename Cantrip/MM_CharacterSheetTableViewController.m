//
//  MM_CharacterSheetTableViewController.m
//  Cantrip
//
//  Created by Mark Murray on 2/22/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_CharacterSheetTableViewController.h"
#import "MM_PlayerCharacter.h"
#import "MM_AbilityScore.h"
#import "MM_SpellSlots.h"
#import "MM_BasicInfoTableViewCell.h"


@interface MM_CharacterSheetTableViewController ()

@property (strong, nonatomic) NSMutableArray *characterInfoToDisplay;

@end

@implementation MM_CharacterSheetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.characterInfoToDisplay = [[NSMutableArray alloc]init];
    
//    [self.characterInfoToDisplay
//     addObject:@[ @[@"Character Name", self.playerCharacter.characterName],
//                  @[@"Class", self.playerCharacter.characterClass],
//                  @[@"", [NSString stringWithFormat:@"Level %@", self.playerCharacter.level]],
//                  @[@"Race", self.playerCharacter.race],
//                  @[@"", [NSString stringWithFormat:@"Age %@", self.playerCharacter.age]],
//                  @[@"Alignment", self.playerCharacter.alignment] ]];
//    [self.characterInfoToDisplay
//     addObject:@[ @[@"Strength", self.playerCharacter.strength],
//                  @[@"Dexterity", self.playerCharacter.dexterity],
//                  @[@"Constitution", self.playerCharacter.constitution],
//                  @[@"Intelligence", self.playerCharacter.intelligence],
//                  @[@"Wisdom", self.playerCharacter.wisdom],
//                  @[@"Charisma", self.playerCharacter.charisma] ]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    NSInteger rows;
    
    switch (section) {
        case 0:
            rows = 1;
            break;
        case 1:
            rows = 6;
            break;
        case 2:
            rows = 2;
            break;
            
        default:
            rows = 1;
            break;
    }
    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *header;
    switch (section) {
        case 0:
            header = @"BASIC IDENTITY";
            break;
        case 1:
            header = @"ATTRIBUTES";
            break;
        case 2:
            header = @"SPELL SLOTS";
            break;
            
        default:
            header = nil;
            break;
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        MM_BasicInfoTableViewCell *basicInfoCell = [tableView dequeueReusableCellWithIdentifier:@"basicInfoCell" forIndexPath:indexPath];
    
        basicInfoCell.playerCharacter = self.playerCharacter;
        [basicInfoCell configureLabels];
        return basicInfoCell;
    }
    else if (indexPath.section == 1) {
        UITableViewCell *abilityScoreCell = [tableView dequeueReusableCellWithIdentifier:@"abilityScoreCell" forIndexPath:indexPath];
        
        MM_AbilityScore *currentAbility = self.playerCharacter.abilityScoresArray[indexPath.row];
        
        NSString *title = [NSString stringWithFormat:@"%@ %@", currentAbility.score, currentAbility.name];
        NSString *subtitle = [NSString stringWithFormat:@"Modifier: %@, Saving Throw : %@", currentAbility.modifier, currentAbility.savingThrow];
        
        abilityScoreCell.textLabel.text = title;
        abilityScoreCell.detailTextLabel.text = subtitle;
        
        return abilityScoreCell;
    }
    else if (indexPath.section == 2) {
        UITableViewCell *spellSlotCell = [tableView dequeueReusableCellWithIdentifier:@"spellSlotsCell" forIndexPath:indexPath];
        
        if (indexPath.row == 0)
        {
            NSMutableString *detailText = [NSMutableString stringWithString:@"Level,count"];
            NSArray *currentSlotsArray = self.playerCharacter.spellSlots.slotMaximums;
                                           
            for (NSInteger i=0; i < [currentSlotsArray count]; i++)
            {
                [detailText appendFormat:@" : %li,%@", i, currentSlotsArray[i] ];
            }
            
            spellSlotCell.textLabel.text = @"Maximum Spell Slots";
            spellSlotCell.detailTextLabel.text = detailText;
            
            return spellSlotCell;
        }
        else if (indexPath.row == 1)
        {

            NSMutableString *detailText = [NSMutableString stringWithString:@"Level,count"];
            NSArray *currentSlotsArray = self.playerCharacter.spellSlots.slotsRemaining;
            
            for (NSInteger i=0; i < [currentSlotsArray count]; i++)
            {
                [detailText appendFormat:@" : %li,%@", i, currentSlotsArray[i] ];
            }
            
            spellSlotCell.textLabel.text = @"Unused Spell Slots";
            spellSlotCell.detailTextLabel.text = detailText;
            
            return spellSlotCell;

        }
        
        
    }
    
    return nil;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
