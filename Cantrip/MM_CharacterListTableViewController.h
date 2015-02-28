//
//  MM_CharacterListTableViewController.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MM_StarterSetDataManager.h"

@interface MM_CharacterListTableViewController : UITableViewController

@property (strong, nonatomic) MM_StarterSetDataManager *starterSetDataManager;

@end
