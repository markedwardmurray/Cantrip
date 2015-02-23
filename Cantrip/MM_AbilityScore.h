//
//  MM_AbilityScore.h
//  Cantrip
//
//  Created by Mark Murray on 2/23/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MM_AbilityScore : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *score;
@property (strong, nonatomic) NSNumber *modifier;
@property (strong, nonatomic) NSNumber *savingThrow;

- (instancetype)init;
- (instancetype)initWithName:(NSString *)name score:(NSNumber *)score;

@end
