//
//  MM_AddSpellToSpellBookTableViewController.h
//  Cantrip
//
//  Created by Mark Murray on 2/28/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Spell;
@class MM_StarterSetDataManager;

@interface MM_AddSpellToSpellBookTableViewController : UITableViewController

@property (strong, nonatomic) MM_StarterSetDataManager *starterSetDataManager;
@property (strong, nonatomic) Spell *selectedSpell;

@end
