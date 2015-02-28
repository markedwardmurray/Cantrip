//
//  MM_SpellSlots.m
//  Cantrip
//
//  Created by Mark Murray on 2/23/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_SpellSlots.h"

@implementation MM_SpellSlots

- (instancetype)init
{
    self = [self initWithSlotMaximums:@[@0, @0, @0, @0, @0, @0, @0, @0, @0, @0]];
    return self;
}

- (instancetype)initWithSlotMaximums:(NSArray *)slotMaximums
{

    self = [super init];
    if (self)
    {
//        _slotMaximums = [[NSMutableArray alloc]init];
//        [self.slotMaximums addObjectsFromArray:slotMaximums];
        
        _slotMaximums = slotMaximums;
        
        _slotsRemaining = slotMaximums;
        
        _level0Slots = [[NSMutableArray alloc]init];
        _level1Slots = [[NSMutableArray alloc]init];
        _level2Slots = [[NSMutableArray alloc]init];
        _level3Slots = [[NSMutableArray alloc]init];
        _level4Slots = [[NSMutableArray alloc]init];
        _level5Slots = [[NSMutableArray alloc]init];
        _level6Slots = [[NSMutableArray alloc]init];
        _level7Slots = [[NSMutableArray alloc]init];
        _level8Slots = [[NSMutableArray alloc]init];
        _level9Slots = [[NSMutableArray alloc]init];
    
        _spellSlotsArray = @[self.level0Slots, self.level1Slots, self.level2Slots,
                             self.level3Slots, self.level4Slots, self.level5Slots,
                             self.level6Slots, self.level7Slots, self.level8Slots, self.level9Slots];
    }
    return self;
}

- (void)calculateSlotsRemaining
{
    NSMutableArray *currentSlotsRemaining;
    for (NSInteger i=0; i<[self.spellSlotsArray count]; i++)
    {
        NSMutableArray *currentLevelSlots = self.spellSlotsArray[i];
        NSInteger usedSlots = [currentLevelSlots count];
        NSInteger remainingSlots = [self.slotMaximums[i] integerValue] - usedSlots;
        [currentSlotsRemaining addObject:@(remainingSlots)];
    }
    self.slotsRemaining = [NSArray arrayWithArray:currentSlotsRemaining];
}

@end
