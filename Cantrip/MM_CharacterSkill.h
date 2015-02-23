//
//  MM_CharacterSkill.h
//  Cantrip
//
//  Created by Mark Murray on 2/22/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MM_CharacterSkill : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *handbook;
@property (strong, nonatomic) NSString *governingAttribute;
@property (strong, nonatomic) NSNumber *skillBonus;

@end
