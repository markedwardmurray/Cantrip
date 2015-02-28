//
//  MM_SpellLibraryTableViewController.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MM_StarterSetDataManager;
@class SpellLibrary;
@class SpellBook;

@interface MM_SpellLibraryTableViewController : UITableViewController

@property (strong, nonatomic) MM_StarterSetDataManager *starterSetDataManager;
@property (strong, nonatomic) SpellLibrary *spellLibrary;
@property (strong, nonatomic) SpellBook *relevantSpellBook;

@end
