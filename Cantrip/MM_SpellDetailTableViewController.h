//
//  MM_SpellDetailTableViewController.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Spell.h"

@class MM_StarterSetDataManager;
@class Spell;
@class SpellBook;

@interface MM_SpellDetailTableViewController : UITableViewController

@property (strong, nonatomic) MM_StarterSetDataManager *starterSetDataManager;
@property (strong, nonatomic) Spell *spell;
@property (strong, nonatomic) SpellBook *relevantSpellBook;

@end
