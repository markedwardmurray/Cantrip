//
//  MM_CreateSpellBookViewController.h
//  Cantrip
//
//  Created by Mark Murray on 2/28/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MM_StarterSetDataManager;
@class PlayerCharacter;

@interface MM_CreateSpellBookViewController : UIViewController

@property (strong, nonatomic) MM_StarterSetDataManager *starterSetDataManager;
@property (strong, nonatomic) PlayerCharacter *playerCharacter;

@end
