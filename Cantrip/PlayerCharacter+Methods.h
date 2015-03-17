//
//  PlayerCharacter+Methods.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "PlayerCharacter.h"
@class CharacterClass;

@interface PlayerCharacter (Methods)

+ (instancetype)createPlayerCharacterWithContext:(NSManagedObjectContext *)context
                                   characterName:(NSString *)characterName
                                  characterClass:(CharacterClass *)characterClass
                                   characterRace:(CharacterRace *)characterRace
                                           level:(NSNumber *)level
                                    strengthRoll:(NSNumber *)strengthRoll
                                   dexterityRoll:(NSNumber *)dexterityRoll
                                constitutionRoll:(NSNumber *)constitutionRoll
                                intelligenceRoll:(NSNumber *)intelligenceRoll
                                      wisdomRoll:(NSNumber *)wisdomRoll
                                    charismaRoll:(NSNumber *)charismaRoll;

@end
