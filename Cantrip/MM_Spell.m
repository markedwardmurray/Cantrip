//
//  MM_Spell.m
//  Cantrip
//
//  Created by Mark Murray on 2/23/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_Spell.h"

@implementation MM_Spell


- (instancetype)init
{
    self = [self initWithName:@""
               allowedClasses:@[]
                        level:@0
                       school:@""
                  castingTime:@""
                        range:@""
                   components:@""
                     duration:@""
             spellDescription:@""];
    return self;
}

- (instancetype)initWithName:(NSString *)name
              allowedClasses:(NSArray *)allowedClasses
                       level:(NSNumber *)level
                      school:(NSString *)school
                 castingTime:(NSString *)castingTime
                       range:(NSString *)range
                  components:(NSString *)components
                    duration:(NSString *)duration
            spellDescription:(NSString *)spellDescription
{
    self = [super init];
    
    if (self)
    {
        _name = name;
        _allowedClasses = allowedClasses;
        _level = level;
        _school = school;
        _castingTime = castingTime;
        _range = range;
        _components = components;
        _duration = duration;
        _spellDescription = spellDescription;
    }
    return self;
}


@end
