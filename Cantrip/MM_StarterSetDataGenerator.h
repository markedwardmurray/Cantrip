//
//  MM_StarterSetDataGenerator.h
//  Cantrip
//
//  Created by Mark Murray on 2/28/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MM_StarterSetDataManager;
@class Publication;

@interface MM_StarterSetDataGenerator : NSObject

@property (strong, nonatomic) MM_StarterSetDataManager *starterSetDataManager;
@property (strong, nonatomic) Publication *publication;

- (void)generatePublication;
- (void)generateCharacterRaces;
- (void)generateCharacterClasses;
- (void)generateSchoolsOfMagic;
- (void)generateStarterSetSpellLibrary;

@end
