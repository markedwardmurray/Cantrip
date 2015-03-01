//
//  MM_StarterSetDataGenerator.h
//  Cantrip
//
//  Created by Mark Murray on 2/28/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MM_StarterSetDataManager;

@interface MM_StarterSetDataGenerator : NSObject

@property (strong, nonatomic) MM_StarterSetDataManager *starterSetDataManager;

- (void)generateCharacterClasses;
- (void)generateSchoolsOfMagic;
- (void)generateStarterSetSpellLibrary;

@end
