//
//  MM_CharacterSheetTableViewController.m
//  Cantrip
//
//  Created by Mark Murray on 2/22/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_CharacterSheetTableViewController.h"
#import "MM_PlayerCharacter.h"
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *header;
    switch (section) {
        case 0:
            header = @"BASIC IDENTITY";
            break;
        case 1:
            header = @"ABILITY SCORES";
            break;
            
        default:
            header = nil;
            break;
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        MM_BasicInfoTableViewCell *basicInfoCell = [tableView dequeueReusableCellWithIdentifier:@"basicInfoCell" forIndexPath:indexPath];
    
        basicInfoCell.playerCharacter = self.playerCharacter;
        [basicInfoCell configureLabels];
        return basicInfoCell;
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
