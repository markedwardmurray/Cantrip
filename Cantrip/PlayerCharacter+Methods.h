//
//  PlayerCharacter+Methods.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "PlayerCharacter.h"

@interface PlayerCharacter (Methods)

+ (instancetype)createPlayerCharacterWithContext:(NSManagedObjectContext *)context
                                   characterName:(NSString *)characterName
                                  characterClass:(CharacterClass *)characterClass;
@end
