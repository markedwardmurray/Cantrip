//
//  MM_SpellBookTableViewController.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MM_StarterSetDataManager;
@class SpellBook;

@interface MM_SpellBookTableViewController : UITableViewController

@property (strong, nonatomic) MM_StarterSetDataManager *starterSetDataManager;
@property (strong, nonatomic) SpellBook *spellBook;
@property (strong, nonatomic) NSArray *spellsArray;

@end
