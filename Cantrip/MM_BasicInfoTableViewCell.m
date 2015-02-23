//
//  MM_BasicInfoTableViewCell.m
//  Cantrip
//
//  Created by Mark Murray on 2/22/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_BasicInfoTableViewCell.h"

@implementation MM_BasicInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureLabels
{
    self.characterNameLabel.text = self.playerCharacter.characterName;
    NSString *descriptionString = [NSString stringWithFormat:@"Level %@ %@ %@ %@", self.playerCharacter.level, self.playerCharacter.gender, self.playerCharacter.race, self.playerCharacter.characterClass];
    self.descriptionLabel.text = descriptionString;
    self.alignmentLabel.text = self.playerCharacter.alignment;
    self.specializationLabel.text = self.playerCharacter.specialization;
    self.experienceLabel.text = [NSString stringWithFormat:@"%@", self.playerCharacter.experiencePoints];
    self.playerNameLabel.text = self.playerCharacter.playerName;
}


@end
