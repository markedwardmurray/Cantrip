//
//  MM_StarterSetDataGenerator.m
//  Cantrip
//
//  Created by Mark Murray on 2/28/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_StarterSetDataGenerator.h"
#import "MM_StarterSetDataManager.h"
#import "PlayerCharacter.h"
#import "PlayerCharacter+Methods.h"
#import "CharacterClass.h"
#import "CharacterClass+Methods.h"
#import "Spell.h"
#import "Spell+Methods.h"
#import "SpellBook.h"
#import "SpellBook+Methods.h"
#import "SchoolOfMagic.h"
#import "SchoolOfMagic+Methods.h"
#import "SpellLibrary.h"
#import "SpellLibrary+Methods.h"

@interface MM_StarterSetDataGenerator ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation MM_StarterSetDataGenerator

- (instancetype)init {
    self = [super init];
    if (self) {
        _starterSetDataManager = [MM_StarterSetDataManager sharedStarterSetDataManager];
        _managedObjectContext = self.starterSetDataManager.managedObjectContext;
    }
    return self;
}

- (void)generateCharacterClasses
{
    CharacterClass *cleric = [CharacterClass createCharacterClassWithContext:self.managedObjectContext
                                                                        name:@"Cleric"];
    CharacterClass *wizard = [CharacterClass createCharacterClassWithContext:self.managedObjectContext
                                                                        name:@"Wizard"];
    self.starterSetDataManager.characterClassesArray = @[cleric, wizard];
    
    [self.starterSetDataManager saveContext];
    [self.starterSetDataManager fetchData];
}

- (void)generateSchoolsOfMagic
{
    SchoolOfMagic *abjuration = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                         name:@"Abjuration"];
    SchoolOfMagic *conjuration = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                          name:@"Conjuration"];
    SchoolOfMagic *divination = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                         name:@"Divination"];
    SchoolOfMagic *enchantment = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                          name:@"Enchantment"];
    SchoolOfMagic *evocation = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                        name:@"Evocation"];
    SchoolOfMagic *illusion = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                       name:@"Illusion"];
    SchoolOfMagic *necromancy = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                         name:@"Necromancy"];
    SchoolOfMagic *transmutation = [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                                                            name:@"Transmutation"];
    self.starterSetDataManager.schoolsOfMagicArray = @[abjuration, conjuration, divination, enchantment,
                                 evocation, illusion, necromancy, transmutation];
    
    [self.starterSetDataManager saveContext];
    [self.starterSetDataManager fetchData];
}

- (void)generateStarterSetSpellLibrary
{
    SpellLibrary *starterSetSpellLibrary = [SpellLibrary createSpellLibraryWithContext:self.managedObjectContext
                                                                                  name:@"D&D 5e Starter Set Spells"];
    
    CharacterClass *cleric = self.starterSetDataManager.characterClassesArray[0];
    CharacterClass *wizard = self.starterSetDataManager.characterClassesArray[1];
    
    SchoolOfMagic *abjuration = self.starterSetDataManager.schoolsOfMagicArray[0];
    SchoolOfMagic *conjuration = self.starterSetDataManager.schoolsOfMagicArray[1];
    SchoolOfMagic *divination = self.starterSetDataManager.schoolsOfMagicArray[2];
    SchoolOfMagic *enchantment = self.starterSetDataManager.schoolsOfMagicArray[3];
    SchoolOfMagic *evocation = self.starterSetDataManager.schoolsOfMagicArray[4];
    SchoolOfMagic *illusion = self.starterSetDataManager.schoolsOfMagicArray[5];
    SchoolOfMagic *necromancy = self.starterSetDataManager.schoolsOfMagicArray[6];
    SchoolOfMagic *transmutation = self.starterSetDataManager.schoolsOfMagicArray[7];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Acid Splash"
                            level:@0
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"You hurl a bubble of acid. Choose one creature within range, or choose two creatures within range that are within 5 feet of each other. A target must succeed on a Dexterity saving throw or take 1d6 acid damage.\n    This spell’s damage increases by 1d6 when you reach 5th level (2d6), 11th level (3d6), and 17th level (4d6)."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Bless"
                            level:@1
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, S, M (a sprinkling of holy water)"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"You bless up to three creatures of your choice within range. Whenever a target makes an attack roll or a saving throw before the spell ends, the target can roll a d4 and add the number rolled to the attack roll or saving throw.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, you can target one additional creature for each slot level above 1st."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Burning Hands"
                            level:@1
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self (15-foot cone)"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"As you hold your hands with thumbs touching and fingers spread, a thin sheet of flames shoots forth from your outstretched fingertips. Each creature in a 15-foot cone must make a Dexterity saving throw. A creature takes 3d6 fire damage on a failed save, or half as much damage on a successful one.\n    The fire ignites any flammable objects in the area that aren’t being worn or carried.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d6 for each slot level above 1st."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Charm Person"
                            level:@1
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, S"
                         duration:@"1 hour"
                 spellDescription:@"You attempt to charm a humanoid you can see within range. It must make a Wisdom saving throw, and does so with advantage if you or your companions are fighting it. If it fails the saving throw, it is charmed by you until the spell ends or until you or your companions do anything harmful to it. The charmed creature regards you as a friendly acquaintance. When the spell ends, the creature knows it was charmed by you.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, you can target one additional creature for each slot level above 1st. The creatures must be within 30 feet of each other when you target them."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Command"
                            level:@1
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V"
                         duration:@"1 round"
                 spellDescription:@"You speak a one-word command to a creature you can see within range. The target must succeed on a Wisdom saving throw or follow the command on its next turn. The spell has no effect if the target is undead, if it doesn’t understand your language, or if your command is directly harmful to it.\n    Some typical commands and their effects follow. You might issue a command other than one described here. If you do so, the DM determines how the target behaves. If the target can’t follow your command, the spell ends.\n    Approach. The target moves toward you by the shortest and most direct route, ending its turn if it moves within 5 feet of you.\n    Drop. The target drops whatever it is holding and then ends its turn.\n    Flee. The target spends its turn moving away from you by the fastest available means.\n    Grovel. The target falls prone and then ends its turn.\n    Halt. The target doesn’t move and takes no actions. A flying creature stays aloft, provided that it is able to do so. If it must move to stay aloft, it flies the minimum distance needed to remain in the air.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, you can affect one additional creature for each slot level above 1st. The creatures must be within 30 feet of each other when you target them."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Comprehend Languages - (ritual)"
                            level:@1
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S, M (a pinch of soot and salt)"
                         duration:@"1 hour"
                 spellDescription:@"For the duration, you understand the literal meaning of any spoken language that you hear. You also understand any written language that you see, but you must be touching the surface on which the words are written. It takes about 1 minute to read one page of text.\n    This spell doesn’t decode secret messages in a text or a glyph, such as an arcane sigil, that isn’t part of a written language."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Cure Wounds"
                            level:@1
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"A creature you touch regains a number of hit points equal to 1d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, the healing increases by 1d8 for each slot level above 1st."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Dancing Lights"
                            level:@0
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"120 feet"
                       components:@"V, S, M (a bit of phosphorus or wychwood, or a glowworm)"
                         duration:@"Concentraion, up to 1 minute"
                 spellDescription:@"You create up to four torch-sized lights within range, making them appear as torches, lanterns, or glowing orbs that hover in the air for the duration. You can also combine the four lights into one glowing vaguely humanoid form of Medium size. Whichever form you choose, each light sheds dim light in a 10-foot radius.\n    As a bonus action on your turn, you can move the lights up to 60 feet to a new spot within range. A light must be within 20 feet of another light created by this spell, and a light winks out if it exceeds the spell’s range."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Detect Magic - (ritual)"
                            level:@1
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric, wizard]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S"
                         duration:@"Concentraion, up to 10 minutes"
                 spellDescription:@"For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any.\n    The spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Disguise Self"
                            level:@1
                    schoolOfMagic:illusion
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S"
                         duration:@"1 hour"
                 spellDescription:@"You make yourself—including your clothing, armor, weapons, and other belongings on your person—look different until the spell ends or until you use your action to dismiss it. You can seem 1 foot shorter or taller and can appear thin, fat, or in between. You can’t change your body type, so you must adopt a form that has the same basic arrangement of limbs. Otherwise, the extent of the illusion is up to you.\n    The changes wrought by this spell fail to hold up to physical inspection. For example, if you use this spell to add a hat to your outfit, objects pass through the hat, and anyone who touches it would feel nothing or would feel your head and hair. If you use this spell to appear thinner than you are, the hand of someone who reaches out to touch you would bump into you while it was seemingly still in midair.\n    To discern that you are disguised, a creature can use its action to inspect your appearance and must succeed on an Intelligence (Investigation) check against your spell save DC."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Fire Bolt"
                            level:@0
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"120 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"You hurl a mote of fire at a creature or object within range. Make a ranged spell attack against the target. On a hit, the target takes 1d10 fire damage. A flammable object hit by this spell ignites if it isn’t being worn or carried.\n    This spell’s damage increases by 1d10 when you reach 5th level (2d10), 11th level (3d10), and 17th level (4d10)."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Guidance"
                            level:@0
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"You touch one willing creature. Once before the spell ends, the target can roll a d4 and add the number rolled to one ability check of its choice. It can roll the die before or after making the ability check. The spell then ends."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Guiding Bolt"
                            level:@1
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"120 feet"
                       components:@"V, S"
                         duration:@"1 round"
                 spellDescription:@"A flash of light streaks toward a creature of your choice within range. Make a ranged spell attack against the target. On a hit, the target takes 4d6 radiant damage, and the next attack roll made against this target before the end of your next turn has advantage, thanks to the mystical dim light glittering on the target until then.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d6 for each slot level above 1st."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Healing Word"
                            level:@1
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 bonus action"
                            range:@"60 feet"
                       components:@"V"
                         duration:@"Instantaneous"
                 spellDescription:@"A creature of your choice that you can see within range regains hit points equal to 1d4 + your spellcasting ability modifier. This spell has no effect on undead or constructs.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, the healing increases by 1d4 for each slot level above 1st."];
        
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Identify - (ritual)"
                            level:@1
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 minute"
                            range:@"Touch"
                       components:@"V, S, M (a pearl worth at least 100 gp and an owl feather)"
                         duration:@"Instantaneous"
                 spellDescription:@"You choose one object that you must touch throughout the casting of the spell. If it is a magic item or some other magic-imbued object, you learn its properties and how to use them, whether it requires attunement to use, and how many charges it has, if any. You learn whether any spells are affecting the item and what they are. If the item was created by a spell, you learn which spell created it.\n    If you instead touch a creature throughout the casting, you learn what spells, if any, are currently affecting it."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Inflict Wounds"
                            level:@1
                    schoolOfMagic:necromancy
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"Make a melee spell attack against a creature you can reach. On a hit, the target takes 3d10 necrotic damage.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d10 for each slot level above 1st."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Light"
                            level:@0
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric, wizard]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, M (a firely or phosphorescent moss)"
                         duration:@"1 hour"
                 spellDescription:@"You touch one object that is no larger than 10 feet in any dimension. Until the spell ends, the object sheds bright light in a 20-foot radius and dim light for an additional 20 feet. The light can be colored as you like. Completely covering the object with something opaque blocks the light. The spell ends if you cast it again or dismiss it as an action.\n    If you target an object held or worn by a hostile creature, that creature must succeed on a Dexterity saving throw to avoid the spell."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Mage Armor"
                            level:@1
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S, M (a piece of cured leather)"
                         duration:@"8 hours"
                 spellDescription:@"You touch a willing creature who isn’t wearing armor, and a protective magical force surrounds it until the spell ends. The target’s base AC becomes 13 + its Dexterity modifier. The spell ends if the target dons armor or if you dismiss the spell as an action."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Mage Hand"
                            level:@0
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, S"
                         duration:@"1 minute"
                 spellDescription:@"A spectral, floating hand appears at a point you choose within range. The hand lasts for the duration or until you dismiss it as an action. The hand vanishes if it is ever more than 30 feet away from you or if you cast this spell again.\n    You can use your action to control the hand. You can use the hand to manipulate an object, open an unlocked door or container, stow or retrieve an item from an open container, or pour the contents out of a vial. You can move the hand up to 30 feet each time you use it.\n    The hand can’t attack, activate magic items, or carry more than 10 pounds."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Magic Missile"
                            level:@1
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"120 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"You create three glowing darts of magical force. Each dart hits a creature of your choice that you can see within range. A dart deals 1d4 + 1 force damage to its target. The darts all strike simultaneously, and you can direct them to hit one creature or several.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, the spell creates one more dart for each slot level above 1st."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Magic Weapon" level:@2
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 bonus action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"Concentration, up to 1 hour"
                 spellDescription:@"You touch a nonmagical weapon. Until the spell ends, that weapon becomes a magic weapon with a +1 bonus to attack rolls and damage rolls.\n    At Higher Levels. When you cast this spell using a spell slot of 4th level or higher, the bonus increases to +2. When you use a spell slot of 6th level or higher, the bonus increases to +3."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Minor Illusion"
                            level:@0
                    schoolOfMagic:illusion
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"S, M (a bit of fleece)"
                         duration:@"1 minute"
                 spellDescription:@"You create a sound or an image of an object within range that lasts for the duration. The illusion also ends if you dismiss it as an action or cast this spell again.\n    If you create a sound, its volume can range from a whisper to a scream. It can be your voice, someone else’s voice, a lion’s roar, a beating of drums, or any other sound you choose. The sound continues unabated throughout the duration, or you can make discrete sounds at different times before the spell ends.\n    If you create an image of an object—such as a chair, muddy footprints, or a small chest—it must be no larger than a 5-foot cube. The image can’t create sound, light, smell, or any other sensory effect. Physical interaction with the image reveals it to be an illusion, because things can pass through it.\n    If a creature uses its action to examine the sound or image, the creature can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC. If a creature discerns the illusion for what it is, the illusion becomes faint to the creature."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Poison Spray"
                            level:@0
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"10 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"You extend your hand toward a creature you can see within range and project a puff of noxious gas from your palm. The creature must succeed on a Constitution saving throw or take 1d12 poison damage.\n    This spell’s damage increases by 1d12 when you reach 5th level (2d12), 11th level (3d12), and 17th level (4d12)."];
    
     [Spell createSpellWithContext:self.managedObjectContext
                              name:@"Prestigitation"
                             level:@0
                     schoolOfMagic:transmutation
                    inSpellLibrary:starterSetSpellLibrary
                 forAllowedClasses:@[wizard]
                       castingTime:@"1 action"
                             range:@"10 feet"
                        components:@"V, S"
                          duration:@"Up to 1 hour"
                  spellDescription:@"This spell is a minor magical trick that novice spellcasters use for practice. You create one of the following magical effects within range:\n• You create an instantaneous, harmless sensory effect, such as a shower of sparks, a puff of wind, faint musical notes, or an odd odor.\n• You instantaneously light or snuff out a candle, a torch, or a small campfire.\n• You instantaneously clean or soil an object no larger than 1 cubic foot.\n• You chill, warm, or flavor up to 1 cubic foot of nonliving material for 1 hour.\n• You make a color, a small mark, or a symbol appear on an object or a surface for 1 hour.\n• You create a nonmagical trinket or an illusory image that can fit in your hand and that lasts until the end of your next turn.\nIf you cast this spell multiple times, you can have up to three of its non-instantaneous effects active at a time, and you can dismiss such an effect as an action."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Protection from Energy"
                            level:@3
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric, wizard]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"Concentration, up to 1 hour"
                 spellDescription:@"For the duration, the willing creature you touch has resistance to one damage type of your choice: acid, cold, fire, lightning, or thunder."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Raise Dead"
                            level:@5
                    schoolOfMagic:necromancy
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 hour"
                            range:@"Touch"
                       components:@"V, S, M (a diamond worth at least 500 gp, which the spell consumes)"
                         duration:@"Instantaneous"
                 spellDescription:@"You return a dead creature you touch to life, provided that it has been dead no longer than 10 days. If the creature’s soul is both willing and at liberty to rejoin the body, the creature returns to life with 1 hit point.\n    This spell also neutralizes any poisons and cures nonmagical diseases that affected the creature at the time it died. This spell doesn’t, however, remove magical diseases, curses, or similar effects; if these aren’t first removed prior to casting the spell, they take effect when the creature returns to life. The spell can’t return an undead creature to life.\n    This spell closes all mortal wounds, but it doesn’t restore missing body parts. If the creature is lacking body parts or organs integral for its survival—its head, for instance—the spell automatically fails.\n    Coming back from the dead is an ordeal. The target takes a −4 penalty to all attack rolls, saving throws, and ability checks. Every time the target finishes a long rest, the penalty is reduced by 1 until it disappears."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Ray of Frost"
                            level:@0
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"A frigid beam of blue-white light streaks toward a creature within range. Make a ranged spell attack against the target. On a hit, it takes 1d8 cold damage, and its speed is reduced by 10 feet until the start of your next turn.\n    The spell’s damage increases by 1d8 when you reach 5th level (2d8), 11th level (3d8), and 17th level (4d8)."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Regeneration"
                            level:@7
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 minute"
                            range:@"Touch"
                       components:@"V, S, M (a prayer wheel and holy water)"
                         duration:@"1 hour"
                 spellDescription:@"You touch a creature and stimulate its natural healing ability. The target regains 4d8 + 15 hit points. For the duration of the spell, the target regains 1 hit point at the start of each of its turns (10 hit points each minute).\n    The target’s severed body members (fingers, legs, tails, and so on), if any, are restored after 2 minutes. If you have the severed part and hold it to the stump, the spell instantaneously causes the limb to knit to the stump."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Remove Curse"
                            level:@3
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"At your touch, all curses affecting one creature or object end. If the object is a cursed magic item, its curse remains, but the spell breaks its owner’s attunement to the object so it can be removed or discarded."];

    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Resistance"
                            level:@0
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S, M (a miniature clock"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"You touch one willing creature. Once before the spell ends, the target can roll a d4 and add the number rolled to one saving throw of its choice. It can roll the die before or after making the saving throw. The spell then ends."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Revivify"
                            level:@3
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S, M (diamonds worth 300 gp, which the spell consumes)"
                         duration:@"Instantaneous"
                 spellDescription:@"You touch a creature that has died within the last minute. That creature returns to life with 1 hit point. This spell can’t return to life a creature that has died of old age, nor can it restore any missing body parts."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Sacred Flame"
                            level:@0
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"Flame-like radiance descends on a creature that you can see within range. The target must succeed on a Dexterity saving throw or take 1d8 radiant damage. The target gains no benefit from cover for this saving throw.\n    The spell’s damage increases by 1d8 when you reach 5th level (2d8), 11th level (3d8), and 17th level (4d8)."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Sanctuary"
                            level:@1
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 bonus action"
                            range:@"30 feet"
                       components:@"V, S, M (a small silver mirror)"
                         duration:@"1 minute"
                 spellDescription:@"You ward a creature within range against attack. Until the spell ends, any creature who targets the warded creature with an attack or a harmful spell must first make a Wisdom saving throw. On a failed save, the creature must choose a new target or lose the attack or spell. This spell doesn’t protect the warded creature from area effects, such as the explosion of a fireball.\n    If the warded creature makes an attack or casts a spell that affects an enemy creature, this spell ends."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Shatter"
                            level:@2
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S, M (a chip of mica)"
                         duration:@"Instantaneous"
                 spellDescription:@"A sudden loud ringing noise, painfully intense, erupts from a point of your choice within range. Each creature in a 10-foot-radius sphere centered on that point must make a Constitution saving throw. A creature takes 3d8 thunder damage on a failed save, or half as much damage on a successful one. A creature made of inorganic material such as stone, crystal, or metal has disadvantage on this saving throw.\n    A nonmagical object that isn’t being worn or carried also takes the damage if it’s in the spell’s area.\n    At Higher Levels. When you cast this spell using a spell slot of 3rd level or higher, the damage increases by 1d8 for each slot level above 2nd."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Sheild"
                            level:@1
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 reaction, which you take when you are hit by an attack or targeted by the magic missile spell"
                            range:@"Self"
                       components:@"V, S"
                         duration:@"1 round"
                 spellDescription:@"An invisible barrier of magical force appears and protects you. Until the start of your next turn, you have a +5 bonus to AC, including against the triggering attack, and you take no damage from magic missile."];
            
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Shield of Faith"
                            level:@1
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 bonus action"
                            range:@"60 feet"
                       components:@"V, S, M (a small parchment with a bit holy text written on it)"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"A shimmering field appears and surrounds a creature of your choice within range, granting it a +2 bonus to AC for the duration."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Shocking Grasp"
                            level:@0
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"Lightning springs from your hand to deliver a shock to a creature you try to touch. Make a melee spell attack against the target. You have advantage on the attack roll if the target is wearing armor made of metal. On a hit, the target takes 1d8 lightning damage, and it can’t take reactions until the start of its next turn.\n    The spell’s damage increases by 1d8 when you reach 5th level (2d8), 11th level (3d8), and 17th level (4d8)."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Silence - (ritual)"
                            level:@2
                    schoolOfMagic:illusion
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"120 feet"
                       components:@"V, S"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"For the duration, no sound can be created within or pass through a 20-foot-radius sphere centered on a point you choose within range. Any creature or object entirely inside the sphere is immune to thunder damage, and creatures are deafened while entirely inside it. Casting a spell that includes a verbal component is impossible there."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Silent Image"
                            level:@1
                    schoolOfMagic:illusion
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S, M (a bit of fleece)"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 15-foot cube. The image appears at a spot within range and lasts for the duration. The image is purely visual; it isn’t accompanied by sound, smell, or other sensory effects.\n    You can use your action to cause the image to move to any spot within range. As the image changes location, you can alter its appearance so that its movements appear natural for the image. For example, if you create an image of a creature and move it, you can alter the image so that it appears to be walking.\n    Physical interaction with the image reveals it to be an illusion, because things can pass through it. A creature that uses its action to examine the image can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC. If a creature discerns the illusion for what it is, the creature can see through the image."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Sleep"
                            level:@1
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"90 feet"
                       components:@"V, S, M (a pinch of fine sand, rose petals, or a cricket)"
                         duration:@"1 minute"
                 spellDescription:@"This spell sends creatures into a magical slumber. Roll 5d8; the total is how many hit points of creatures this spell can affect. Creatures within 20 feet of a point you choose within range are affected in ascending order of their current hit points (ignoring unconscious creatures).\n   Starting with the creature that has the lowest current hit points, each creature affected by this spell falls unconscious until the spell ends, the sleeper takes damage, or someone uses an action to shake or slap the sleeper awake. Subtract each creature’s hit points from the total before moving on to the creature with the next lowest hit points. A creature’s hit points must be equal to or less than the remaining total for that creature to be affected.\n    Undead and creatures immune to being charmed aren’t affected by this spell.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, roll an additional 2d8 for each slot level above 1st."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Spare the Dying"
                            level:@0
                    schoolOfMagic:necromancy
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"You touch a living creature that has 0 hit points. The creature becomes stable. This spell has no effect on undead or constructs."];
  
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Speak with Dead"
                            level:@3
                    schoolOfMagic:necromancy
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"10 feet"
                       components:@"V, S, M (burning incense)"
                         duration:@"10 minutes"
                 spellDescription:@"You grant the semblance of life and intelligence to a corpse of your choice within range, allowing it to answer the questions you pose. The corpse must still have a mouth and can’t be undead. The spell fails if the corpse was the target of this spell within the last 10 days.\n    Until the spell ends, you can ask the corpse up to five questions. The corpse knows only what it knew in life, including the languages it knew. Answers are usually brief, cryptic, or repetitive, and the corpse is under no compulsion to offer a truthful answer if you are hostile to it or it recognizes you as an enemy. This spell doesn’t return the creature’s soul to its body, only its animating spirit. Thus, the corpse can’t learn new information, doesn’t comprehend anything that has happened since it died, and can’t speculate about future events."];
            
            
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"True Resurrection"
                            level:@9
                    schoolOfMagic:necromancy
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 hour"
                            range:@"Touch"
                       components:@"V, S, M (a sprinkle of holy water and diamonds worth at least 25,000 gp, which the spell consumes)"
                         duration:@"Instantaneous"
                 spellDescription:@"You touch a creature that has been dead for no longer than 200 years and that died for any reason except old age. If the creature’s soul is free and willing, the creature is restored to life with all its hit points.\n    This spell closes all wounds, neutralizes any poison, cures all diseases, and lifts any curses affecting the creature when it died. The spell replaces damaged or missing organs and limbs.\n    The spell can even provide a new body if the original no longer exists, in which case you must speak the creature’s name. The creature then appears in an unoccupied space you choose within 10 feet of you."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"True Seeing"
                            level:@6
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric, wizard]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S, M (an ointment for the eyes that costs 25 gp; is made from powder, saffron and fat; and is consumed by the spell)"
                         duration:@"1 hour"
                 spellDescription:@"This spell gives the willing creature you touch the ability to see things as they actually are. For the duration, the creature has truesight, notices secret doors hidden by magic, and can see into the Ethereal Plane, all out to a range of 120 feet."];
                
    [self.starterSetDataManager saveContext];
    [self.starterSetDataManager fetchData];
}



@end
