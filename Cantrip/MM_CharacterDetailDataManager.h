//
//  MM_CharacterDetailDataManager.h
//  Cantrip
//
//  Created by Mark Murray on 4/20/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MM_StarterSetDataManager;
@class PlayerCharacter;

@interface MM_CharacterDetailDataManager : NSObject

@property (strong, nonatomic) MM_StarterSetDataManager *starterSetDataManager;

@property (strong, nonatomic) PlayerCharacter *playerCharacter;
@property (strong, nonatomic) NSMutableArray *displayData;
@property (strong, nonatomic) NSMutableArray *sectionHeaders;

- (instancetype)initWithPlayerCharacter:(PlayerCharacter *)playerCharacter;

- (void)organizeDisplayDataAndSectionHeaders;

@end
