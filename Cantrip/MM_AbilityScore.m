//
//  MM_AbilityScore.m
//  Cantrip
//
//  Created by Mark Murray on 2/23/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_AbilityScore.h"

@implementation MM_AbilityScore

- (instancetype)init
{
    self = [self initWithName:@"" score:@0];
    return self;
}

- (instancetype)initWithName:(NSString *)name score:(NSNumber *)score
{
    self = [super init];
    if (self)
    {
        _name = name;
        _score = score;
        
        NSInteger modifierInt = ([score integerValue] - 10) / 2;
        _modifier = @(modifierInt);
        
        _savingThrow = [self calculateSavingThrowWithProficiencyBonus:@2];
    }
    return self;
}

- (NSNumber *)calculateSavingThrowWithProficiencyBonus:(NSNumber *)proficiencyBonus
{
    NSInteger savingThrowInt = 8 + [proficiencyBonus integerValue] + [self.modifier integerValue];
    
    return @(savingThrowInt);
}

@end
