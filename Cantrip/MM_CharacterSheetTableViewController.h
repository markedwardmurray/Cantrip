//
//  MM_CharacterSheetTableViewController.h
//  Cantrip
//
//  Created by Mark Murray on 2/22/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MM_PlayerCharacter;

@interface MM_CharacterSheetTableViewController : UITableViewController

@property (strong, nonatomic) MM_PlayerCharacter *playerCharacter;

@end
