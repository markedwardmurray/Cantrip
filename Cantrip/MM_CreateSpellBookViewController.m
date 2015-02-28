//
//  MM_CreateSpellBookViewController.m
//  Cantrip
//
//  Created by Mark Murray on 2/28/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_CreateSpellBookViewController.h"
#import "MM_StarterSetDataManager.h"
#import "PlayerCharacter.h"
#import "SpellBook+Methods.h"

@interface MM_CreateSpellBookViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

- (IBAction)cancelTapped:(id)sender;
- (IBAction)createTapped:(id)sender;

@end

@implementation MM_CreateSpellBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString *newSpellBookName = [NSString stringWithFormat:@"%@ Spell Book", self.nameTextField.text];
    [SpellBook createSpellBookWithContext:self.starterSetDataManager.managedObjectContext
                                     name:newSpellBookName
                          playerCharacter:self.playerCharacter];
    [self.starterSetDataManager saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
