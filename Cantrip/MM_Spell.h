//
//  MM_Spell.h
//  Cantrip
//
//  Created by Mark Murray on 2/23/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MM_Spell : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *allowedClasses;
@property (strong, nonatomic) NSNumber *level;
@property (strong, nonatomic) NSString *school;
@property (strong, nonatomic) NSString *castingTime;

@property (strong, nonatomic) NSString *range;
@property (strong, nonatomic) NSString *components;
@property (strong, nonatomic) NSString *duration;
@property (strong, nonatomic) NSString *spellDescription;

- (instancetype)init;
- (instancetype)initWithName:(NSString *)name
              allowedClasses:(NSArray *)allowedClasses
                       level:(NSNumber *)level
                      school:(NSString *)school
                 castingTime:(NSString *)castingTime
                       range:(NSString *)range
                  components:(NSString *)components
                    duration:(NSString *)duration
            spellDescription:(NSString *)spellDescription;

@end
