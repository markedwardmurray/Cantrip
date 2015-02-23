//
//  MM_SpellSlots.h
//  Cantrip
//
//  Created by Mark Murray on 2/23/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MM_Spell.h"

@interface MM_SpellSlots : NSObject

@property (strong, nonatomic) NSMutableArray *slotMaximums;
@property (strong, nonatomic) NSMutableArray *slotsRemaining;

@property (strong, nonatomic) NSArray *spellSlotsArray;
@property (strong, nonatomic) NSMutableArray *level0Slots;
@property (strong, nonatomic) NSMutableArray *level1Slots;
@property (strong, nonatomic) NSMutableArray *level2Slots;
@property (strong, nonatomic) NSMutableArray *level3Slots;
@property (strong, nonatomic) NSMutableArray *level4Slots;
@property (strong, nonatomic) NSMutableArray *level5Slots;
@property (strong, nonatomic) NSMutableArray *level6Slots;
@property (strong, nonatomic) NSMutableArray *level7Slots;
@property (strong, nonatomic) NSMutableArray *level8Slots;
@property (strong, nonatomic) NSMutableArray *level9Slots;

- (instancetype)initWithSlotMaximums:(NSArray *)slotMaximums;

@end
