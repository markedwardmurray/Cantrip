//
//  MM_BasicInfoTableViewCell.h
//  Cantrip
//
//  Created by Mark Murray on 2/22/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MM_PlayerCharacter.h"

@interface MM_BasicInfoTableViewCell : UITableViewCell

@property (strong, nonatomic) MM_PlayerCharacter *playerCharacter;

@property (weak, nonatomic) IBOutlet UILabel *characterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *alignmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceLabel;
@property (weak, nonatomic) IBOutlet UILabel *specializationLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerNameLabel;

- (void)configureLabels;

@end
