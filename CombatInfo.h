//
//  CombatInfo.h
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PlayerCharacter;

@interface CombatInfo : NSManagedObject

@property (nonatomic, retain) NSNumber * hitPointsMax;
@property (nonatomic, retain) NSNumber * hitPointsCurrent;
@property (nonatomic, retain) NSNumber * armorClass;
@property (nonatomic, retain) NSNumber * initiativeModifier;
@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) NSNumber * hitPointsTemporary;
@property (nonatomic, retain) PlayerCharacter *playerCharacter;

@end
