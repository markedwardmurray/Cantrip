//
//  MM_AddCharacterViewController.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_AddCharacterViewController.h"
#import "MM_StarterSetDataManager.h"
#import "CharacterClass.h"
#import "PlayerCharacter+Methods.h"

@interface MM_AddCharacterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *createCharacterLabel;

@property (weak, nonatomic) IBOutlet UITextField *characterNameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *characterClassSelector;

@property (weak, nonatomic) IBOutlet UIButton *createButton;

- (IBAction)cancelTapped:(id)sender;
- (IBAction)createTapped:(id)sender;

@end

@implementation MM_AddCharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
    
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createTapped:(id)sender {
    NSString *newCharacterName = self.characterNameTextField.text;
    NSInteger characterClassIndex = [self.characterClassSelector selectedSegmentIndex];
    CharacterClass *selectedCharacterClass = self.starterSetDataManager.characterClassesArray[characterClassIndex];
    
//    PlayerCharacter *newPlayerCharacter =
    [PlayerCharacter
        createPlayerCharacterWithContext:self.starterSetDataManager.managedObjectContext
                           characterName:newCharacterName
                          characterClass:selectedCharacterClass];
    
    [self.starterSetDataManager saveContext];
    
    UIAlertView *characterCreated = [[UIAlertView alloc]initWithTitle:@"Character Created!" message:@"Now to find a dungeon..." delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
    [characterCreated show];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
