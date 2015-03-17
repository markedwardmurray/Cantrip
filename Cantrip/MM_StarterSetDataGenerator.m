//
//  MM_StarterSetDataGenerator.m
//  Cantrip
//
//  Created by Mark Murray on 2/28/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "MM_StarterSetDataGenerator.h"
#import "MM_StarterSetDataManager.h"
#import "GameSystem.h"
#import "Publication.h"
#import "CharacterRace+Methods.h"
#import "PlayerCharacter+Methods.h"
#import "CharacterClass+Methods.h"
#import "Spell+Methods.h"
#import "SpellBook+Methods.h"
#import "SchoolOfMagic+Methods.h"
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

- (void)generatePublication {
    Publication *dnd5EStarterSet = [NSEntityDescription insertNewObjectForEntityForName:@"Publication" inManagedObjectContext:self.managedObjectContext];
    dnd5EStarterSet.name = @"Starter Set, D&D 5th Edition";
    [dnd5EStarterSet setGameSystem:self.starterSetDataManager.gameSystems[0]];
    self.publication = dnd5EStarterSet;
    
    [self generateCharacterRaces];
    [self generateCharacterClasses];
    [self generateSchoolsOfMagic];
    
    [self.starterSetDataManager saveContext];
    [self.starterSetDataManager fetchData];
}

- (void)generateCharacterRaces {
    [CharacterRace createCharacterRaceWithContext:self.managedObjectContext
                                             name:@"Dwarf"
                                      publication:self.publication
                                      information:@"dwarves"];
    
    [CharacterRace createCharacterRaceWithContext:self.managedObjectContext
                                             name:@"Elf"
                                      publication:self.publication
                                      information:@"elves"];
    
    [CharacterRace createCharacterRaceWithContext:self.managedObjectContext
                                             name:@"Halfling"
                                      publication:self.publication
                                      information:@"halflings"];
    
    [CharacterRace createCharacterRaceWithContext:self.managedObjectContext
                                             name:@"Human"
                                      publication:self.publication
                                      information:@"humans"];
    
    [self.starterSetDataManager saveContext];
}

- (void)generateCharacterClasses
{
    [CharacterClass createCharacterClassWithContext:self.managedObjectContext
                                               name:@"Cleric"
                                        publication:self.publication];
    
    [CharacterClass createCharacterClassWithContext:self.managedObjectContext
                                               name:@"Fighter"
                                        publication:self.publication];
    
    [CharacterClass createCharacterClassWithContext:self.managedObjectContext
                                               name:@"Rogue"
                                        publication:self.publication];
    
    [CharacterClass createCharacterClassWithContext:self.managedObjectContext
                                               name:@"Wizard"
                                        publication:self.publication];
    
    [self.starterSetDataManager saveContext];
}

- (void)generateSchoolsOfMagic
{
    [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                             name:@"Abjuration"];
    [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                             name:@"Conjuration"];
    [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                             name:@"Divination"];
    [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                             name:@"Enchantment"];
    [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                             name:@"Evocation"];
    [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                             name:@"Illusion"];
    [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                             name:@"Necromancy"];
    [SchoolOfMagic createSchoolOfMagicWithContext:self.managedObjectContext
                                             name:@"Transmutation"];
    
    [self.starterSetDataManager saveContext];
    [self.starterSetDataManager fetchData];
}

# pragma mark - Generate Spell Library

- (void)generateStarterSetSpellLibrary
{

    SpellLibrary *starterSetSpellLibrary =
            [SpellLibrary createSpellLibraryWithContext:self.managedObjectContext
                                                   name:@"D&D 5e Starter Set Spells"
                                            publication:self.publication];
    
    CharacterClass *cleric = self.starterSetDataManager.characterClassesArray[0];
    CharacterClass *wizard = self.starterSetDataManager.characterClassesArray[3];
    
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
                             name:@"Aid"
                            level:@2
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, S, M (a tiny strip of white cloth)"
                         duration:@"8 hours"
                 spellDescription:@"Your spell bolsters your allies with toughness and resolve. Choose up to three creatures within range. Each target’s hit point maximum and current hit points increase by 5 for the duration.\n    At Higher Levels. When you cast this spell using a spell slot of 3rd level or higher, a target’s hit points increase by an additional 5 for each slot level above 2nd."];
            
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Antimagic Field"
                            level:@8
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Self (10-foot-radius-sphere)"
                       components:@"V, S, M (a pinch of powdered iron or iron filings)"
                         duration:@"Concentration, up to 1 hour"
                 spellDescription:@"A 10-foot-radius invisible sphere of antimagic surrounds you. This area is divorced from the magical energy that suffuses the multiverse. Within the sphere, spells can’t be cast, summoned creatures disappear, and even magic items become mundane. Until the spell ends, the sphere moves with you, centered on you.\n    Spells and other magical effects, except those created by an artifact or a deity, are suppressed in the sphere and can’t protrude into it. A slot expended to cast a suppressed spell is consumed. While an effect is suppressed, it doesn’t function, but the time it spends suppressed counts against its duration.\n    Targeted Effects. Spells and other magical effects, such as magic missile and charm person, that target a creature or an object in the sphere have no effect on that target.\n    Areas of Magic. The area of another spell or magical effect, such as fireball, can’t extend into the sphere. If the sphere overlaps an area of magic, the part of the area that is covered by the sphere is suppressed. For example, the flames created by a wall of fire are suppressed within the sphere, creating a gap in the wall if the overlap is large enough.\n    Spells. Any active spell or other magical effect on a creature or an object in the sphere is suppressed while the creature or object is in it.\n    Magic Items. The properties and powers of magic items are suppressed in the sphere. For example, a +1 longsword in the sphere functions as a nonmagical longsword.\n    A magic weapon’s properties and powers are suppressed if it is used against a target in the sphere or wielded by an attacker in the sphere. If a magic weapon or a piece of magic ammunition fully leaves the sphere (for example, if you fire a magic arrow or throw a magic spear at a target outside the sphere), the magic of the item ceases to be suppressed as soon as it exits.\n    Magical Travel. Teleportation and planar travel fail to work in the sphere, whether the sphere is the destination or the departure point for such magical travel. A portal to another location, world, or plane of existence, as well as an opening to an extradimensional space such as that created by the rope trick spell, temporarily closes while in the sphere.\n    Creatures and Objects. A creature or object summoned or created by magic temporarily winks out of existence in the sphere. Such a creature instantly reappears once the space the creature occupied is no longer within the sphere.\n    Dispel Magic. Spells and magical effects such as dispel magic have no effect on the sphere. Likewise, the spheres created by different antimagic field spells don’t nullify each other."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Arcane Eye"
                            level:@4
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, S, M (a bit of bat fur)"
                         duration:@"Concentration, up to 1 hour"
                 spellDescription:@"You create an invisible, magical eye within range that hovers in the air for the duration.\n    You mentally receive visual information from the eye, which has normal vision and darkvision out to 30 feet. The eye can look in every direction.\n    As an action, you can move the eye up to 30 feet in any direction. There is no limit to how far away from you the eye can move, but it can’t enter another plane of existence. A solid barrier blocks the eye’s movement, but the eye can pass through an opening as small as 1 inch in diameter."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Arcane Lock"
                            level:@2
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Rouch"
                       components:@"V, S, M(gold dust worth at least 25 gp, which the spell consumes)"
                         duration:@"Until dispelled"
                 spellDescription:@"You touch a closed door, window, gate, chest, or other entryway, and it becomes locked for the duration. You and the creatures you designate when you cast this spell can open the object normally. You can also set a password that, when spoken within 5 feet of the object, suppresses this spell for 1 minute. Otherwise, it is impassable until it is broken or the spell is dispelled or suppressed. Casting knock on the object suppresses arcane lock for 10 minutes.\n    While affected by this spell, the object is more difficult to break or force open; the DC to break it or pick any locks on it increases by 10."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Astral Projection"
                            level:@9
                    schoolOfMagic:necromancy
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 hour"
                            range:@"10 feet"
                       components:@"V, S, M (for each creature you affect with this spell, you must provide one jacinth worth at least 1,000 gp and one ornately carved bar of silver worth at least 100 gp, all of which the spell consumes)"
                         duration:@"Special"
                 spellDescription:@"You and up to eight willing creatures within range project your astral bodies into the Astral Plane (the spell fails and the casting is wasted if you are already on that plane). The material body you leave behind is unconscious and in a state of suspended animation; it doesn’t need food or air and doesn’t age.\n    Your astral body resembles your mortal form in almost every way, replicating your game statistics and possessions. The principal difference is the addition of a silvery cord that extends from between your shoulder blades and trails behind you, fading to invisibility after 1 foot. This cord is your tether to your material body. As long as the tether remains intact, you can find your way home. If the cord is cut—something that can happen only when an effect specifically states that it does—your soul and body are separated, killing you instantly.\n    Your astral form can freely travel through the Astral Plane and can pass through portals there leading to any other plane. If you enter a new plane or return to the plane you were on when casting this spell, your body and possessions are transported along the silver cord, allowing you to re-enter your body as you enter the new plane.\n    Your astral form is a separate incarnation. Any damage or other effects that apply to it have no effect on your physical body, nor do they persist when you return to it.\n    The spell ends for you and your companions when you use your action to dismiss it. When the spell ends, the affected creature returns to its physical body, and it awakens.\n    The spell might also end early for you or one of your companions. A successful dispel magic spell used against an astral or physical body ends the spell for that creature. If a creature’s original body or its astral form drops to 0 hit points, the spell ends for that creature. If the spell ends and the silver cord is intact, the cord pulls the creature’s astral form back to its body, ending its state of suspended animation.\n    If you are returned to your body prematurely, your companions remain in their astral forms and must find their own way back to their bodies, usually by dropping to 0 hit points."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Augury - (ritual)"
                            level:@2
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 minute"
                            range:@"Self"
                       components:@"V, S, M (specially marked sticks, bones, or similar token worth at least 25 gp)"
                         duration:@"Instantaneous"
                 spellDescription:@"By casting gem-inlaid sticks, rolling dragon bones, laying out ornate cards, or employing some other divining tool, you receive an omen from an otherworldly entity about the results of a specific course of action that you plan to take within the next 30 minutes. The DM chooses from the following possible omens:\n• Weal, for good results\n• Woe, for bad results\n• Weal and woe, for both good and bad results\n• Nothing, for results that aren’t especially good or bad\nThe spell doesn’t take into account any possible circumstances that might change the outcome, such as the casting of additional spells or the loss or gain of a companion.\n    If you cast the spell two or more times before completing your next long rest, there is a cumulative 25 percent chance for each casting after the first that you get a random reading. The DM makes this roll in secret."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Beacon of Hope"
                            level:@3
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, S"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"This spell bestows hope and vitality. Choose any number of creatures within range. For the duration, each target has advantage on Wisdom saving throws and death saving throws, and regains the maximum number of hit points possible from any healing."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Blade Barrier"
                            level:@6
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"90 feet"
                       components:@"V, S"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"You create a vertical wall of whirling, razor-sharp blades made of magical energy. The wall appears within range and lasts for the duration. You can make a straight wall up to 100 feet long, 20 feet high, and 5 feet thick, or a ringed wall up to 60 feet in diameter, 20 feet high, and 5 feet thick. The wall provides three-quarters cover to creatures behind it, and its space is difficult terrain.\n    When a creature enters the wall’s area for the first time on a turn or starts its turn there, the creature must make a Dexterity saving throw. On a failed save, the creature takes 6d10 slashing damage. On a successful save, the creature takes half as much damage."];
    
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
                             name:@"Blur"
                            level:@2
                    schoolOfMagic:illusion
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"Your body becomes blurred, shifting and wavering to all who can see you. For the duration, any creature has disadvantage on attack rolls against you. An attacker is immune to this effect if it doesn’t rely on sight, as with blindsight, or can see through illusions, as with truesight."];
    
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
                             name:@"Chain Lightning"
                            level:@6
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"150 feet"
                       components:@"V, S, M (a bit of fur; a piece of amber, glass, or a crystal rod; and three silver pins)"
                         duration:@"Instantaneous"
                 spellDescription:@"You create a bolt of lightning that arcs toward a target of your choice that you can see within range. Three bolts then leap from that target to as many as three other targets, each of which must be within 30 feet of the first target. A target can be a creature or an object and can be targeted by only one of the bolts.\n    A target must make a Dexterity saving throw. The target takes 10d8 lightning damage on a failed save, or half as much damage on a successful one.\n    At Higher Levels. When you cast this spell using a spell slot of 7th level or higher, one additional bolt leaps from the first target to another target for each slot level above 6th."];
    
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
                             name:@"Commune - (ritual)"
                            level:@5
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 minute"
                            range:@"Self"
                       components:@"V, S, M (incense and a vial of holy or unholy water)"
                         duration:@"1 minute"
                 spellDescription:@"You contact your deity or a divine proxy and ask up to three questions that can be answered with a yes or no. You must ask your questions before the spell ends. You receive a correct answer for each question.\n    Divine beings aren’t necessarily omniscient, so you might receive “unclear” as an answer if a question pertains to information that lies beyond the deity’s knowledge. In a case where a one-word answer could be misleading or contrary to the deity’s interests, the DM might offer a short phrase as an answer instead.\n    If you cast the spell two or more times before finishing your next long rest, there is a cumulative 25 percent chance for each casting after the first that you get no answer. The DM makes this roll in secret."];
    
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
                             name:@"Cone of Cold"
                            level:@5
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self (60-foot cone)"
                       components:@"V, S, M (a small crystal or glass cone)"
                         duration:@"Instantaneous"
                 spellDescription:@"A blast of cold air erupts from your hands. Each creature in a 60-foot cone must make a Constitution saving throw. A creature takes 8d8 cold damage on a failed save, or half as much damage on a successful one.\n    A creature killed by this spell becomes a frozen statue until it thaws.\n    At Higher Levels. When you cast this spell using a spell slot of 6th level or higher, the damage increases by 1d8 for each slot level above 5th."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Counterspell"
                            level:@3
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 reaction, which you take when you see a creature within 60 feet of you casting a spell"
                            range:@"60 feet"
                       components:@"S"
                         duration:@"Instantaneous"
                 spellDescription:@"You attempt to interrupt a creature in the process of casting a spell. If the creature is casting a spell of 3rd level or lower, its spell fails and has no effect. If it is casting a spell of 4th level or higher, make an ability check using your spellcasting ability. The DC equals 10 + the spell’s level. On a success, the creature’s spell fails and has no effect.\n    At Higher Levels. When you cast this spell using a spell slot of 4th level or higher, the interrupted spell has no effect if its level is less than or equal to the level of the spell slot you used."];
    
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
    
# pragma mark - Spells: D
    
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
                             name:@"Darkness"
                            level:@2
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, M (bat fur and a drop of pitch or piece of coal)"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"Magical darkness spreads from a point you choose within range to fill a 15-foot-radius sphere for the duration. The darkness spreads around corners. A creature with darkvision can’t see through this darkness, and nonmagical light can’t illuminate it.\n    If the point you choose is on an object you are holding or one that isn’t being worn or carried, the darkness emanates from the object and moves with it. Completely covering the source of the darkness with an opaque object, such as a bowl or a helm, blocks the darkness.\n    If any of this spell’s area overlaps with an area of light created by a spell of 2nd level or lower, the spell that created the light is dispelled."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Death Ward"
                            level:@4
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"8 hours"
                 spellDescription:@"You touch a creature and grant it a measure of protection from death.\n    The first time the target would drop to 0 hit points as a result of taking damage, the target instead drops to 1 hit point, and the spell ends.\n    If the spell is still in effect when the target is subjected to an effect that would kill it instantaneously without dealing damage, that effect is instead negated against the target, and the spell ends."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Delayed Blast Fireball"
                            level:@7
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"150 feet"
                       components:@"V, S, M (a tiny ball of bat guano and sulfer)"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"A beam of yellow light flashes from your pointing finger, then condenses to linger at a chosen point within range as a glowing bead for the duration. When the spell ends, either because your concentration is broken or because you decide to end it, the bead blossoms with a low roar into an explosion of flame that spreads around corners. Each creature in a 20-foot-radius sphere centered on that point must make a Dexterity saving throw. A creature takes fire damage equal to the total accumulated damage on a failed save, or half as much damage on a successful one.\n    The spell’s base damage is 12d6. If at the end of your turn the bead has not yet detonated, the damage increases by 1d6.\n    If the glowing bead is touched before the interval has expired, the creature touching it must make a Dexterity saving throw. On a failed save, the spell ends immediately, causing the bead to erupt in flame. On a successful save, the creature can throw the bead up to 40 feet. When it strikes a creature or a solid object, the spell ends, and the bead explodes.\n    The fire damages objects in the area and ignites flammable objects that aren’t being worn or carried.\n    At Higher Levels. When you cast this spell using a spell slot of 8th level or higher, the base damage increases by 1d6 for each slot level above 7th."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Detect Magic - (ritual)"
                            level:@1
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric, wizard]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"For the duration, you sense the presence of magic within 30 feet of you. If you sense magic in this way, you can use your action to see a faint aura around any visible creature or object in the area that bears magic, and you learn its school of magic, if any.\n    The spell can penetrate most barriers, but it is blocked by 1 foot of stone, 1 inch of common metal, a thin sheet of lead, or 3 feet of wood or dirt."];
        
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Dimension Door"
                            level:@4
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"500 feet"
                       components:@"V"
                         duration:@"Instantaneous"
                 spellDescription:@"You teleport yourself from your current location to any other spot within range. You arrive at exactly the spot desired. It can be a place you can see, one you can visualize, or one you can describe by stating distance and direction, such as “200 feet straight downward” or “upward to the northwest at a 45-degree angle, 300 feet.”\n    You can bring along objects as long as their weight doesn’t exceed what you can carry. You can also bring one willing creature of your size or smaller who is carrying gear up to its carrying capacity. The creature must be within 5 feet of you when you cast this spell.\n    If you would arrive in a place already occupied by an object or a creature, you and any creature traveling with you each take 4d6 force damage, and the spell fails to teleport you."];
    
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
                             name:@"Disintegrate"
                            level:@6
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S, M (a lodestone and a pinch of dust"
                         duration:@"Instantaneous"
                 spellDescription:@"A thin green ray springs from your pointing finger to a target that you can see within range. The target can be a creature, an object, or a creation of magical force, such as the wall created by wall of force.\n    A creature targeted by this spell must make a Dexterity saving throw. On a failed save, the target takes 10d6 + 40 force damage. If this damage reduces the target to 0 hit points, it is disintegrated.\n    A disintegrated creature and everything it is wearing and carrying, except magic items, are reduced to a pile of fine gray dust. The creature can be restored to life only by means of a true resurrection or a wish spell.\n    This spell automatically disintegrates a Large or smaller nonmagical object or a creation of magical force. If the target is a Huge or larger object or creation of force, this spell disintegrates a 10-foot-cube portion of it. A magic item is unaffected by this spell.\n    At Higher Levels. When you cast this spell using a spell slot of 7th level or higher, the damage increases by 3d6 for each slot level above 6th."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Dispel Magic"
                            level:@3
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric, wizard]
                      castingTime:@"1 action"
                            range:@"120 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"Choose one creature, object, or magical effect within range. Any spell of 3rd level or lower on the target ends. For each spell of 4th level or higher on the target, make an ability check using your spellcasting ability. The DC equals 10 + the spell’s level. On a successful check, the spell ends.\n    At Higher Levels. When you cast this spell using a spell slot of 4th level or higher, you automatically end the effects of a spell on the target if the spell’s level is equal to or less than the level of the spell slot you used."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Divination - (ritual)"
                            level:@4
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S, M (incense and a sacrificial offering appropriate to your religion, together worth at least 25 gp, which the spell consumes)"
                         duration:@"Instantaneous"
                 spellDescription:@"Your magic and an offering put you in contact with a god or a god’s servants. You ask a single question concerning a specific goal, event, or activity to occur within 7 days. The DM offers a truthful reply. The reply might be a short phrase, a cryptic rhyme, or an omen.\n    The spell doesn’t take into account any possible circumstances that might change the outcome, such as the casting of additional spells or the loss or gain of a companion.\n    If you cast the spell two or more times before finishing your next long rest, there is a cumulative 25 percent chance for each casting after the first that you get a random reading. The DM makes this roll in secret."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Dominate Monster"
                            level:@8
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Concentration, up to 1 hour"
                 spellDescription:@"You attempt to beguile a creature that you can see within range. It must succeed on a Wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw.\n    While the creature is charmed, you have a telepathic link with it as long as the two of you are on the same plane of existence. You can use this telepathic link to issue commands to the creature while you are conscious (no action required), which it does its best to obey. You can specify a simple and general course of action, such as “Attack that creature,” “Run over there,” or “Fetch that object.” If the creature completes the order and doesn’t receive further direction from you, it defends and preserves itself to the best of its ability.\n    You can use your action to take total and precise control of the target. Until the end of your next turn, the creature takes only the actions you choose, and doesn’t do anything that you don’t allow it to do. During this time, you can also cause the creature to use a reaction, but this requires you to use your own reaction as well.\n    Each time the target takes damage, it makes a new Wisdom saving throw against the spell. If the saving throw succeeds, the spell ends.\n    At Higher Levels. When you cast this spell with a 9th-level spell slot, the duration is concentration, up to 8 hours."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Dominate Person"
                            level:@5
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"You attempt to beguile a humanoid that you can see within range. It must succeed on a Wisdom saving throw or be charmed by you for the duration. If you or creatures that are friendly to you are fighting it, it has advantage on the saving throw.\n    While the target is charmed, you have a telepathic link with it as long as the two of you are on the same plane of existence. You can use this telepathic link to issue commands to the creature while you are conscious (no action required), which it does its best to obey. You can specify a simple and general course of action, such as “Attack that creature,” “Run over there,” or “Fetch that object.” If the creature completes the order and doesn’t receive further direction from you, it defends and preserves itself to the best of its ability.\n    You can use your action to take total and precise control of the target. Until the end of your next turn, the creature takes only the actions you choose, and doesn’t do anything that you don’t allow it to do. During this time you can also cause the creature to use a reaction, but this requires you to use your own reaction as well.\n    Each time the target takes damage, it makes a new Wisdom saving throw against the spell. If the saving throw succeeds, the spell ends.\n    At Higher Levels. When you cast this spell using a 6th-level spell slot, the duration is concentration, up to 10 minutes. When you use a 7th-level spell slot, the duration is concentration, up to 1 hour. When you use a spell slot of 8th level or higher, the duration is concentration, up to 8 hours."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Dream"
                            level:@5
                    schoolOfMagic:illusion
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 minute"
                            range:@"Special"
                       components:@"V, S, M (a handful of sand, a dab of ink, and a writing quill plucked from a sleeping bird)"
                         duration:@"8 hours"
                 spellDescription:@"This spell shapes a creature’s dreams. Choose a creature known to you as the target of this spell. The target must be on the same plane of existence as you. Creatures that don’t sleep, such as elves, can’t be contacted by this spell. You, or a willing creature you touch, enters a trance state, acting as a messenger. While in the trance, the messenger is aware of his or her surroundings, but can’t take actions or move.\n    If the target is asleep, the messenger appears in the target’s dreams and can converse with the target as long as it remains asleep, through the duration of the spell. The messenger can also shape the environment of the dream, creating landscapes, objects, and other images. The messenger can emerge from the trance at any time, ending the effect of the spell early. The target recalls the dream perfectly upon waking. If the target is awake when you cast the spell, the messenger knows it, and can either end the trance (and the spell) or wait for the target to fall asleep, at which point the messenger appears in the target’s dreams.\n    You can make the messenger appear monstrous and terrifying to the target. If you do, the messenger can deliver a message of no more than ten words and then the target must make a Wisdom saving throw. On a failed save, echoes of the phantasmal monstrosity spawn a nightmare that lasts the duration of the target’s sleep and prevents the target from gaining any benefit from that rest. In addition, when the target wakes up, it takes 3d6 psychic damage.\n    If you have a body part, lock of hair, clipping from a nail, or similar portion of the target’s body, the target makes its saving throw with disadvantage."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Earthquake"
                            level:@8
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"500 feet"
                       components:@"V, S, M (a pinch of dirt, a piece of rock, and a lump of clay)"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"You create a seismic disturbance at a point on the ground that you can see within range. For the duration, an intense tremor rips through the ground in a 100-foot-radius circle centered on that point and shakes creatures and structures in contact with the ground in that area.\n    The ground in the area becomes difficult terrain. Each creature on the ground that is concentrating must make a Constitution saving throw. On a failed save, the creature’s concentration is broken.\n    When you cast this spell and at the end of each turn you spend concentrating on it, each creature on the ground in the area must make a Dexterity saving throw. On a failed save, the creature is knocked prone.\n    This spell can have additional effects depending on the terrain in the area, as determined by the DM.\n    Fissures. Fissures open throughout the spell’s area at the start of your next turn after you cast the spell. A total of 1d6 such fissures open in locations chosen by the DM. Each is 1d10 × 10 feet deep, 10 feet wide, and extends from one edge of the spell’s area to the opposite side. A creature standing on a spot where a fissure opens must succeed on a Dexterity saving throw or fall in. A creature that successfully saves moves with the fissure’s edge as it opens.\n    A fissure that opens beneath a structure causes it to automatically collapse (see below).\n    Structures. The tremor deals 50 bludgeoning damage to any structure in contact with the ground in the area when you cast the spell and at the start of each of your turns until the spell ends. If a structure drops to 0 hit points, it collapses and potentially damages nearby creatures. A creature within half the distance of a structure’s height must make a Dexterity saving throw. On a failed save, the creature takes 5d6 bludgeoning damage, is knocked prone, and is buried in the rubble, requiring a DC 20 Strength (Athletics) check as an action to escape. The DM can adjust the DC higher or lower, depending on the nature of the rubble. On a successful save, the creature takes half as much damage and doesn’t fall prone or become buried."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Etherealness"
                            level:@7
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S"
                         duration:@"Up to 8 hours"
                 spellDescription:@"You step into the border regions of the Ethereal Plane, in the area where it overlaps with your current plane. You remain in the Border Ethereal for the duration or until you use your action to dismiss the spell. During this time, you can move in any direction. If you move up or down, every foot of movement costs an extra foot. You can see and hear the plane you originated from, but everything there looks gray, and you can’t see anything more than 60 feet away.\n    While on the Ethereal Plane, you can only affect and be affected by other creatures on that plane. Creatures that aren’t on the Ethereal Plane can’t perceive you and can’t interact with you, unless a special ability or magic has given them the ability to do so.\n    You ignore all objects and effects that aren’t on the Ethereal Plane, allowing you to move through objects you perceive on the plane you originated from.\n    When the spell ends, you immediately return to the plane you originated from in the spot you currently occupy. If you occupy the same spot as a solid object or creature when this happens, you are immediately shunted to the nearest unoccupied space that you can occupy and take force damage equal to twice the number of feet you are moved.\n    This spell has no effect if you cast it while you are on the Ethereal Plane or a plane that doesn’t border it, such as one of the Outer Planes.\n    At Higher Levels. When you cast this spell using a spell slot of 8th level or higher, you can target up to three willing creatures (including you) for each slot level above 7th. The creatures must be within 10 feet of you when you cast the spell."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Find the Path"
                            level:@6
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 minute"
                            range:@"Self"
                       components:@"V, S, M (a set of divinatory tools-such as bones, ivory sticks, cards, teeth, or carved runes-worth 100 gp and an object from the location you wish to find)"
                         duration:@"Concentration, up to 1 day"
                 spellDescription:@"This spell allows you to find the shortest, most direct physical route to a specific fixed location that you are familiar with on the same plane of existence. If you name a destination on another plane of existence, a destination that moves (such as a mobile fortress), or a destination that isn’t specific (such as “a green dragon’s lair”), the spell fails.\n    For the duration, as long as you are on the same plane of existence as the destination, you know how far it is and in what direction it lies. While you are traveling there, whenever you are presented with a choice of paths along the way, you automatically determine which path is the shortest and most direct route (but not necessarily the safest route) to the destination."];

    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Faerie Fire"
                            level:@1
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[] // bard and druid only, in 5e PH
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"Each object in a 20-foot cube within range is outlined in blue, green, or violet light (your choice). Any creature in the area when the spell is cast is also outlined in light if it fails a Dexterity saving throw. For the duration, objects and affected creatures shed dim light in a 10-foot radius.\n    Any attack roll against an affected creature or object has advantage if the attacker can see it, and the affected creature or object can’t benefit from being invisible."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Finger of Death"
                            level:@7
                    schoolOfMagic:necromancy
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"You send negative energy coursing through a creature that you can see within range, causing it searing pain. The target must make a Constitution saving throw. It takes 7d8 + 30 necrotic damage on a failed save, or half as much damage on a successful one.\n    A humanoid killed by this spell rises at the start of your next turn as a zombie that is permanently under your command, following your verbal orders to the best of its ability."];
        
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Fireball"
                            level:@3
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"150 feet"
                       components:@"V, S, M (a tiny ball of bat guano and sulfer)"
                         duration:@"Instantaneous"
                 spellDescription:@"A bright streak flashes from your pointing finger to a point you choose within range and then blossoms with a low roar into an explosion of flame. Each creature in a 20-foot-radius sphere centered on that point must make a Dexterity saving throw. A target takes 8d6 fire damage on a failed save, or half as much damage on a successful one.\n    The fire spreads around corners. It ignites flammable objects in the area that aren’t being worn or carried.\n    At Higher Levels. When you cast this spell using a spell slot of 4th level or higher, the damage increases by 1d6 for each slot level above 3rd."];
    
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
                             name:@"Fire Storm"
                            level:@7
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"150 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"A storm made up of sheets of roaring flame appears in a location you choose within range. The area of the storm consists of up to ten 10-foot cubes, which you can arrange as you wish. Each cube must have at least one face adjacent to the face of another cube. Each creature in the area must make a Dexterity saving throw. It takes 7d10 fire damage on a failed save, or half as much damage on a successful one.\n    The fire damages objects in the area and ignites flammable objects that aren’t being worn or carried. If you choose, plant life in the area is unaffected by this spell."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Flame Strike"
                            level:@5
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S, M (pinch of sulfer"
                         duration:@"Instantaneous"
                 spellDescription:@"A vertical column of divine fire roars down from the heavens in a location you specify. Each creature in a 10-foot-radius, 40-foot-high cylinder centered on a point within range must make a Dexterity saving throw. A creature takes 4d6 fire damage and 4d6 radiant damage on a failed save, or half as much damage on a successful one.\n    At Higher Levels. When you cast this spell using a spell slot of 6th level or higher, the fire damage or the radiant damage (your choice) increases by 1d6 for each slot level above 5th."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Flaming Sphere"
                            level:@2
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S, M (a bit of tallow, a pinch of brimstone, and a dusting of powdered iron)"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"A 5-foot-diameter sphere of fire appears in an unoccupied space of your choice within range and lasts for the duration. Any creature that ends its turn within 5 feet of the sphere must make a Dexterity saving throw. The creature takes 2d6 fire damage on a failed save, or half as much damage on a successful one.\n    As a bonus action, you can move the sphere up to 30 feet. If you ram the sphere into a creature, that creature must make the saving throw against the sphere’s damage, and the sphere stops moving this turn.\n    When you move the sphere, you can direct it over barriers up to 5 feet tall and jump it across pits up to 10 feet wide. The sphere ignites flammable objects not being worn or carried, and it sheds bright light in a 20-foot radius and dim light for an additional 20 feet.\n    At Higher Levels. When you cast this spell using a spell slot of 3rd level or higher, the damage increases by 1d6 for each slot level above 2nd."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Fly"
                            level:@3
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S, M (a wing feather from any bird)"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"You touch a willing creature. The target gains a flying speed of 60 feet for the duration. When the spell ends, the target falls if it is still aloft, unless it can stop the fall.\n    At Higher Levels. When you cast this spell using a spell slot of 4th level or higher, you can target one additional creature for each slot level above 3rd."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Foresight"
                            level:@9
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 minute"
                            range:@"Touch"
                       components:@"V, S, M (a hummingbird feather)"
                         duration:@"8 hours"
                 spellDescription:@"You touch a willing creature and bestow a limited ability to see into the immediate future. For the duration, the target can’t be surprised and has advantage on attack rolls, ability checks, and saving throws. Additionally, other creatures have disadvantage on attack rolls against the target for the duration.\n    This spell immediately ends if you cast it again before its duration ends."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Freedom of Movement"
                            level:@4
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S, M (a leather strap, bound around the arm or a similar appendage)"
                         duration:@"1 hour"
                 spellDescription:@"You touch a willing creature. For the duration, the target’s movement is unaffected by difficult terrain, and spells and other magical effects can neither reduce the target’s speed nor cause the target to be paralyzed or restrained.\n    The target can also spend 5 feet of movement to automatically escape from nonmagical restraints, such as manacles or a creature that has it grappled. Finally, being underwater imposes no penalties on the target’s movement or attacks."];
    
# pragma mark - Spells: G
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Gate"
                            level:@9
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S, M (a diamond worth at least 5,000 gp)"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"You conjure a portal linking an unoccupied space you can see within range to a precise location on a different plane of existence. The portal is a circular opening, which you can make 5 to 20 feet in diameter. You can orient the portal in any direction you choose. The portal lasts for the duration.\n    The portal has a front and a back on each plane where it appears. Travel through the portal is possible only by moving through its front. Anything that does so is instantly transported to the other plane, appearing in the unoccupied space nearest to the portal.\n    Deities and other planar rulers can prevent portals created by this spell from opening in their presence or anywhere within their domains.\n    When you cast this spell, you can speak the name of a specific creature (a pseudonym, title, or nickname doesn’t work). If that creature is on a plane other than the one you are on, the portal opens in the creature’s immediate vicinity and draws the creature through it to the nearest unoccupied space on your side of the portal. You gain no special power over the creature, and it is free to act as the DM deems appropriate. It might leave, attack you, or help you."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Globe of Invulnerability"
                            level:@6
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self (10-foot radius)"
                       components:@"V, S, M (a glass or crystal bead that shatters when the spell ends)"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"An immobile, faintly shimmering barrier springs into existence in a 10-foot radius around you and remains for the duration.\n    Any spell of 5th level or lower cast from outside the barrier can’t affect creatures or objects within it, even if the spell is cast using a higher level spell slot. Such a spell can target creatures and objects within the barrier, but the spell has no effect on them. Similarly, the area within the barrier is excluded from the areas affected by such spells.\n    At Higher Levels. When you cast this spell using a spell slot of 7th level or higher, the barrier blocks spells of one level higher for each slot level above 6th."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Greater Invisibility"
                            level:@4
                    schoolOfMagic:illusion
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"You or a creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target’s person."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Greater Restoration"
                            level:@5
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S, M (diamond dust worth at least 100 gp, which the spell consumes)"
                         duration:@"Instantaneous"
                 spellDescription:@"You imbue a creature you touch with positive energy to undo a debilitating effect. You can reduce the target’s exhaustion level by one, or end one of the following effects on the target:\n• One effect that charmed or petrified the target\n• One curse, including the target’s attunement to a cursed magic item\n• Any reduction to one of the target’s ability scores\n• One effect reducing the target’s hit point maximum"];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Guardian of Faith"
                            level:@4
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V"
                         duration:@"8 hours"
                 spellDescription:@"A Large spectral guardian appears and hovers for the duration in an unoccupied space of your choice that you can see within range. The guardian occupies that space and is indistinct except for a gleaming sword and shield emblazoned with the symbol of your deity.\n    Any creature hostile to you that moves to a space within 10 feet of the guardian for the first time on a turn must succeed on a Dexterity saving throw. The creature takes 20 radiant damage on a failed save, or half as much damage on a successful one. The guardian vanishes when it has dealt a total of 60 damage."];
    
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
                             name:@"Harm"
                            level:@6
                    schoolOfMagic:necromancy
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"You unleash a virulent disease on a creature that you can see within range. The target must make a Constitution saving throw. On a failed save, it takes 14d6 necrotic damage, or half as much damage on a successful save. The damage can’t reduce the target’s hit points below 1. If the target fails the saving throw, its hit point maximum is reduced for 1 hour by an amount equal to the necrotic damage it took. Any effect that removes a disease allows a creature’s hit point maximum to return to normal before that time passes."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Haste"
                            level:@3
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, S, M (a shaving of licorice root)"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"Choose a willing creature that you can see within range. Until the spell ends, the target’s speed is doubled, it gains a +2 bonus to AC, it has advantage on Dexterity saving throws, and it gains an additional action on each of its turns. That action can be used only to take the Attack (one weapon attack only), Dash, Disengage, Hide, or Use an Object action.\n    When the spell ends, the target can’t move or take actions until after its next turn, as a wave of lethargy sweeps over it."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Heal"
                            level:@6
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"Choose a creature that you can see within range. A surge of positive energy washes through the creature, causing it to regain 70 hit points. This spell also ends blindness, deafness, and any diseases affecting the target. This spell has no effect on constructs or undead.\n    At Higher Levels. When you cast this spell using a spell slot of 7th level or higher, the amount of healing increases by 10 for each slot level above 6th."];
    
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
                             name:@"Heroes' Feast"
                            level:@6
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"10 minutes"
                            range:@"30 feet"
                       components:@"V, S, M (a gem-encrusted bowl worth at least 1,000 gp, which the spell consumes)"
                         duration:@"Instantaneous"
                 spellDescription:@"You bring forth a great feast, including magnificent food and drink. The feast takes 1 hour to consume and disappears at the end of that time, and the beneficial effects don’t set in until this hour is over. Up to twelve other creatures can partake of the feast.\n    A creature that partakes of the feast gains several benefits. The creature is cured of all diseases and poison, becomes immune to poison and being frightened, and makes all Wisdom saving throws with advantage. Its hit point maximum also increases by 2d10, and it gains the same number of hit points. These benefits last for 24 hours."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Hold Person"
                            level:@2
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric, wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S, M (a small, straight piece of iron)"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"Choose a humanoid that you can see within range. The target must succeed on a Wisdom saving throw or be paralyzed for the duration. At the end of each of its turns, the target can make another Wisdom saving throw. On a success, the spell ends on the target.\n    At Higher Levels. When you cast this spell using a spell slot of 3rd level or higher, you can target one additional humanoid for each slot level above 2nd. The humanoids must be within 30 feet of each other when you target them."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Holy Aura"
                            level:@8
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S, M (a tiny reliquary worth at least 1,000 gp containing a sacred relic, such as a scrap of cloth from a saint’s robe or a piece of parchment from a religious text)"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"Divine light washes out from you and coalesces in a soft radiance in a 30-foot radius around you. Creatures of your choice in that radius when you cast this spell shed dim light in a 5-foot radius and have advantage on all saving throws, and other creatures have disadvantage on attack rolls against them until the spell ends. In addition, when a fiend or an undead hits an affected creature with a melee attack, the aura flashes with brilliant light. The attacker must succeed on a Constitution saving throw or be blinded until the spell ends."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Ice Storm"
                            level:@4
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"300 feet"
                       components:@"V, S, M (a pinch of dust and a few drops of water)"
                         duration:@"Instantaneous"
                 spellDescription:@"A hail of rock-hard ice pounds to the ground in a 20-foot-radius, 40-foot-high cylinder centered on a point within range. Each creature in the cylinder must make a Dexterity saving throw. A creature takes 2d8 bludgeoning damage and 4d6 cold damage on a failed save, or half as much damage on a successful one. Hailstones turn the storm’s area of effect into difficult terrain until the end of your next turn.\n    At Higher Levels. When you cast this spell using a spell slot of 5th level or higher, the bludgeoning damage increases by 1d8 for each slot level above 4th."];
    
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
                             name:@"Imprisonment"
                            level:@9
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 minute"
                            range:@"30 feet"
                       components:@"V, S, M (a vellum depiction or a carved statuette in the likeness of the target, and a special component that varies according to the version of the spell you choose, worth at least 500 gp per Hit Die of the target)"
                         duration:@"Until dispelled"
                 spellDescription:@"You create a magical restraint to hold a creature that you can see within range. The target must succeed on a Wisdom saving throw or be bound by the spell; if it succeeds, it is immune to this spell if you cast it again. While affected by this spell, the creature doesn’t need to breathe, eat, or drink, and it doesn’t age. Divination spells can’t locate or perceive the target.\n    When you cast the spell, you choose one of the following forms of imprisonment.\n    Burial. The target is entombed far beneath the earth in a sphere of magical force that is just large enough to contain the target. Nothing can pass through the sphere, nor can any creature teleport or use planar travel to get into or out of it.\n    The special component for this version of the spell is a small mithral orb.\n    Chaining. Heavy chains, firmly rooted in the ground, hold the target in place. The target is restrained until the spell ends, and it can’t move or be moved by any means until then.\n    The special component for this version of the spell is a fine chain of precious metal.\n    Hedged Prison. The spell transports the target into a tiny demiplane that is warded against teleportation and planar travel. The demiplane can be a labyrinth, a cage, a tower, or any similar confined structure or area of your choice.\n    The special component for this version of the spell is a miniature representation of the prison made from jade.\n    Minimus Containment. The target shrinks to a height of 1 inch and is imprisoned inside a gemstone or similar object. Light can pass through the gemstone normally (allowing the target to see out and other creatures to see in), but nothing else can pass through, even by means of teleportation or planar travel. The gemstone can’t be cut or broken while the spell remains in effect.\n    The special component for this version of the spell is a large, transparent gemstone, such as a corundum, diamond, or ruby.\n    Slumber. The target falls asleep and can’t be awoken. The special component for this version of the spell consists of rare soporific herbs.\n    Ending the Spell. During the casting of the spell, in any of its versions, you can specify a condition that will cause the spell to end and release the target. The condition can be as specific or as elaborate as you choose, but the DM must agree that the condition is reasonable and has a likelihood of coming to pass. The conditions can be based on a creature’s name, identity, or deity but otherwise must be based on observable actions or qualities and not based on intangibles such as level, class, or hit points.\n    A dispel magic spell can end the spell only if it is cast as a 9th-level spell, targeting either the prison or the special component used to create it.\n    You can use a particular special component to create only one prison at a time. If you cast the spell again using the same component, the target of the first casting is immediately freed from its binding."];
    
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
                              name:@"Invisibility"
                             level:@2
                    schoolOfMagic:illusion
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S, M (an eyelash encased in gum arabic)"
                         duration:@"Concentration, up to 1 hour"
                 spellDescription:@"A creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target’s person. The spell ends for a target that attacks or casts a spell.\n    At Higher Levels. When you cast this spell using a spell slot of 3rd level or higher, you can target one additional creature for each slot level above 2nd."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Knock"
                            level:@2
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V"
                         duration:@"Instantaneous"
                 spellDescription:@"Choose an object that you can see within range. The object can be a door, a box, a chest, a set of manacles, a padlock, or another object that contains a mundane or magical means that prevents access.\n    A target that is held shut by a mundane lock or that is stuck or barred becomes unlocked, unstuck, or unbarred. If the object has multiple locks, only one of them is unlocked.\n    If you choose a target that is held shut with arcane lock, that spell is suppressed for 10 minutes, during which time the target can be opened and shut normally.\n    When you cast the spell, a loud knock, audible from as far away as 300 feet, emanates from the target object."];
    
# pragma mark - Spells: J
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Lesser Restoration"
                            level:@2
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"You touch a creature and can end either one disease orone condition afflicting it. The condition can be blinded, deafened, paralyzed, or poisoned."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Levitate"
                            level:@2
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S, M (either a small leather loop or a piece of golden wire bent into a cup shape with a long shank on one end)"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"One creature or object of your choice that you can see within range rises vertically, up to 20 feet, and remains suspended there for the duration. The spell can levitate a target that weighs up to 500 pounds. An unwilling creature that succeeds on a Constitution saving throw is unaffected.\n    The target can move only by pushing or pulling against a fixed object or surface within reach (such as a wall or a ceiling), which allows it to move as if it were climbing. You can change the target’s altitude by up to 20 feet in either direction on your turn. If you are the target, you can move up or down as part of your move. Otherwise, you can use your action to move the target, which must remain within the spell’s range.\n    When the spell ends, the target floats gently to the ground if it is still aloft."];
    
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
                             name:@"Lightning Bolt"
                            level:@3
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self (100-foot line)"
                       components:@"V, S , M (a bit of fur and a rod of amber, crystal, or glass)"
                         duration:@"Instantaneous"
                 spellDescription:@"A stroke of lightning forming a line 100 feet long and 5 feet wide blasts out from you in a direction you choose. Each creature in the line must make a Dexterity saving throw. A creature takes 8d6 lightning damage on a failed save, or half as much damage on a successful one.\n    The lightning ignites flammable objects in the area that aren’t being worn or carried.\n    At Higher Levels. When you cast this spell using a spell slot of 4th level or higher, the damage increases by 1d6 for each slot level above 3rd."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Locate Creature"
                            level:@4
                    schoolOfMagic:divination
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S, M (a bit of fur from a bloodhound)"
                         duration:@"Concentration, up to 1 hour"
                 spellDescription:@"Describe or name a creature that is familiar to you. You sense the direction to the creature’s location, as long as that creature is within 1,000 feet of you. If the creature is moving, you know the direction of its movement.\n    The spell can locate a specific creature known to you, or the nearest creature of a specific kind (such as a human or a unicorn), so long as you have seen such a creature up close—within 30 feet—at least once. If the creature you described or named is in a different form, such as being under the effects of a polymorph spell, this spell doesn’t locate the creature.\n    This spell can’t locate a creature if running water at least 10 feet wide blocks a direct path between you and the creature."];
    
# pragma mark - Spells: M
    
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
                             name:@"Major Image"
                            level:@3
                    schoolOfMagic:illusion
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"120 feet"
                       components:@"V, S, M (a bit of fleece)"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"You create the image of an object, a creature, or some other visible phenomenon that is no larger than a 20-foot cube. The image appears at a spot that you can see within range and lasts for the duration. It seems completely real, including sounds, smells, and temperature appropriate to the thing depicted. You can’t create sufficient heat or cold to cause damage, a sound loud enough to deal thunder damage or deafen a creature, or a smell that might sicken a creature (like a troglodyte’s stench).\n    As long as you are within range of the illusion, you can use your action to cause the image to move to any other spot within range. As the image changes location, you can alter its appearance so that its movements appear natural for the image. For example, if you create an image of a creature and move it, you can alter the image so that it appears to be walking. Similarly, you can cause the illusion to make different sounds at different times, even making it carry on a conversation, for example.\n    Physical interaction with the image reveals it to be an illusion, because things can pass through it. A creature that uses its action to examine the image can determine that it is an illusion with a successful Intelligence (Investigation) check against your spell save DC. If a creature discerns the illusion for what it is, the creature can see through the image, and its other sensory qualities become faint to the creature.\n    At Higher Levels. When you cast this spell using a spell slot of 6th level or higher, the spell lasts until dispelled, without requiring your concentration."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Mass Cure Wounds"
                            level:@5
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"A wave of healing energy washes out from a point of your choice within range. Choose up to six creatures in a 30-foot-radius sphere centered on that point. Each target regains hit points equal to 3d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.\n    At Higher Levels. When you cast this spell using a spell slot of 6th level or higher, the healing increases by 1d8 for each slot level above 5th."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Mass Heal"
                            level:@9
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"A flood of healing energy flows from you into injured creatures around you. You restore up to 700 hit points, divided as you choose among any number of creatures that you can see within range. Creatures healed by this spell are also cured of all diseases and any effect making them blinded or deafened. This spell has no effect on undead or constructs."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Mass Healing Word"
                            level:@3
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 bonus action"
                            range:@"60 feet"
                       components:@"V"
                         duration:@"Instantaneous"
                 spellDescription:@"As you call out words of restoration, up to six creatures of your choice that you can see within range regain hit points equal to 1d4 + your spellcasting ability modifier. This spell has no effect on undead or constructs.\n    At Higher Levels. When you cast this spell using a spell slot of 4th level or higher, the healing increases by 1d4 for each slot level above 3rd."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Mass Suggestion"
                            level:@6
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, M (a snake's tongue and either a bit of honeycomb or a drop of sweet oil)"
                         duration:@"24 hours"
                 spellDescription:@"You suggest a course of activity (limited to a sentence or two) and magically influence up to twelve creatures of your choice that you can see within range and that can hear and understand you. Creatures that can’t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act automatically negates the effect of the spell.\n    Each target must make a Wisdom saving throw. On a failed save, it pursues the course of action you described to the best of its ability. The suggested course of action can continue for the entire duration. If the suggested activity can be completed in a shorter time, the spell ends when the subject finishes what it was asked to do.\n    You can also specify conditions that will trigger a special activity during the duration. For example, you might suggest that a group of soldiers give all their money to the first beggar they meet. If the condition isn’t met before the spell ends, the activity isn’t performed.\n    If you or any of your companions damage a creature affected by this spell, the spell ends for that creature.\n    At Higher Levels. When you cast this spell using a 7th-level spell slot, the duration is 10 days. When you use an 8th-level spell slot, the duration is 30 days. When you use a 9th-level spell slot, the duration is a year and a day."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Maze"
                            level:@8
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"You banish a creature that you can see within range into a labyrinthine demiplane. The target remains there for the duration or until it escapes the maze.\n    The target can use its action to attempt to escape. When it does so, it makes a DC 20 Intelligence check. If it succeeds, it escapes, and the spell ends (a minotaur or goristro demon automatically succeeds).\n    When the spell ends, the target reappears in the space it left or, if that space is occupied, in the nearest unoccupied space."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Meteor Swarm"
                            level:@9
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"1 mile"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"Blazing orbs of fire plummet to the ground at four different points you can see within range. Each creature in a 40-foot-radius sphere centered on each point you choose must make a Dexterity saving throw. The sphere spreads around corners. A creature takes 20d6 fire damage and 20d6 bludgeoning damage on a failed save, or half as much damage on a successful one. A creature in the area of more than one fiery burst is affected only once.\n    The spell damages objects in the area and ignites flammable objects that aren’t being worn or carried."];
    
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
                             name:@"Misty Step"
                            level:@2
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 bonus action"
                            range:@"Self"
                       components:@"V"
                         duration:@"Instantaneous"
                 spellDescription:@"Briefly surrounded by silvery mist, you teleport up to 30 feet to an unoccupied space that you can see."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Mordenkainen's Sword"
                            level:@7
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S, M (a miniature platinum sword with a grip and pommel of copper and zinc, worth 250 gp)"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"You create a sword-shaped plane of force that hovers within range. It lasts for the duration.\n    When the sword appears, you make a melee spell attack against a target of your choice within 5 feet of the sword. On a hit, the target takes 3d10 force damage. Until the spell ends, you can use a bonus action on each of your turns to move the sword up to 20 feet to a spot you can see and repeat this attack against the same target or a different one."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Otto's Irresistible Dance"
                            level:@6
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"Choose one creature that you can see within range. The target begins a comic dance in place: shuffling, tapping its feet, and capering for the duration. Creatures that can’t be charmed are immune to this spell.\n    A dancing creature must use all its movement to dance without leaving its space and has disadvantage on Dexterity saving throws and attack rolls. While the target is affected by this spell, other creatures have advantage on attack rolls against it. As an action, a dancing creature makes a Wisdom saving throw to regain control of itself. On a successful save, the spell ends."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Passwall"
                            level:@5
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, S, M (a pinch of sesame seeds)"
                         duration:@"1 hour"
                 spellDescription:@"A passage appears at a point of your choice that you can see on a wooden, plaster, or stone surface (such as a wall, a ceiling, or a floor) within range, and lasts for the duration. You choose the opening’s dimensions: up to 5 feet wide, 8 feet tall, and 20 feet deep. The passage creates no instability in a structure surrounding it.\n    When the opening disappears, any creatures or objects still in the passage created by the spell are safely ejected to an unoccupied space nearest to the surface on which you cast the spell."];

# pragma mark - Spells: P
        
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
                             name:@"Power Word Kill"
                            level:@9
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V"
                         duration:@"Instantaneous"
                 spellDescription:@"You utter a word of power that can compel one creature you can see within range to die instantly. If the creature you choose has 100 hit points or fewer, it dies. Otherwise, the spell has no effect."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Power Word Stun"
                            level:@8
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V"
                         duration:@"Instantaneous"
                 spellDescription:@"You speak a word of power that can overwhelm the mind of one creature you can see within range, leaving it dumbfounded. If the target has 150 hit points or fewer, it is stunned. Otherwise, the spell has no effect.\n    The stunned target must make a Constitution saving throw at the end of each of its turns. On a successful save, this stunning effect ends."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Prayer of Healing"
                            level:@2
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"10 minutes"
                            range:@"30 feet"
                       components:@"V"
                         duration:@"Instantaneous"
                 spellDescription:@"Up to six creatures of your choice that you can see within range each regain hit points equal to 2d8 + your spellcasting ability modifier. This spell has no effect on undead or constructs.\n    At Higher Levels. When you cast this spell using a spell slot of 3rd level or higher, the healing increases by 1d8 for each slot level above 2nd."];
    
     [Spell createSpellWithContext:self.managedObjectContext
                              name:@"Prestidigitation"
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
                             name:@"Resurrection"
                            level:@7
                    schoolOfMagic:necromancy
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 hour"
                            range:@"Touch"
                       components:@"V, S, M (a diamond worth at least 1,000 gp, which the spell consumes)"
                         duration:@"Instantaneous"
                 spellDescription:@"You touch a dead creature that has been dead for no more than a century, that didn’t die of old age, and that isn’t undead. If its soul is free and willing, the target returns to life with all its hit points.\n    This spell neutralizes any poisons and cures normal diseases afflicting the creature when it died. It doesn’t, however, remove magical diseases, curses, and the like; if such effects aren’t removed prior to casting the spell, they afflict the target on its return to life.\n    This spell closes all mortal wounds and restores any missing body parts.\n    Coming back from the dead is an ordeal. The target takes a −4 penalty to all attack rolls, saving throws, and ability checks. Every time the target finishes a long rest, the penalty is reduced by 1 until it disappears.\n    Casting this spell to restore life to a creature that has been dead for one year or longer taxes you greatly. Until you finish a long rest, you can’t cast spells again, and you have disadvantage on all attack rolls, ability checks, and saving throws."];
    
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
    
# pragma mark Spells: S
    
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
                             name:@"Shield"
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
                             name:@"Spider Climb"
                            level:@2
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S, M (a drop of bitumen and a spider)"
                         duration:@"Concentration, up to 1 hour"
                 spellDescription:@"Until the spell ends, one willing creature you touch gains the ability to move up, down, and across vertical surfaces and upside down along ceilings, while leaving its hands free. The target also gains a climbing speed equal to its walking speed."];
        
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Spirit Guardians"
                            level:@3
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Self (15-foot radius)"
                       components:@"V, S, M (a holy symbol)"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"You call forth spirits to protect you. They flit around you to a distance of 15 feet for the duration. If you are good or neutral, their spectral form appears angelic or fey (your choice). If you are evil, they appear fiendish.\n    When you cast this spell, you can designate any number of creatures you can see to be unaffected by it. An affected creature’s speed is halved in the area, and when the creature enters the area for the first time on a turn or starts its turn there, it must make a Wisdom saving throw. On a failed save, the creature takes 3d8 radiant damage (if you are good or neutral) or 3d8 necrotic damage (if you are evil). On a successful save, the creature takes half as much damage.\n    At Higher Levels. When you cast this spell using a spell slot of 4th level or higher, the damage increases by 1d8 for each slot level above 3rd."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Spiritual Weapon"
                            level:@2
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 bonus action"
                            range:@"60 feet"
                       components:@"V, S"
                         duration:@"1 minute"
                 spellDescription:@"You create a floating, spectral weapon within range that lasts for the duration or until you cast this spell again. When you cast the spell, you can make a melee spell attack against a creature within 5 feet of the weapon. On a hit, the target takes force damage equal to 1d8 + your spellcasting ability modifier.\n    As a bonus action on your turn, you can move the weapon up to 20 feet and repeat the attack against a creature within 5 feet of it.\n    The weapon can take whatever form you choose. Clerics of deities who are associated with a particular weapon (as St. Cuthbert is known for his mace and Thor for his hammer) make this spell’s effect resemble that weapon.\n    At Higher Levels. When you cast this spell using a spell slot of 3rd level or higher, the damage increases by 1d8 for every two slot levels above the 2nd."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Stoneskin"
                            level:@4
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S, M (diamond dust worth 100 gp, which the spell consumes)"
                         duration:@"Concentration, up to 1 hour"
                 spellDescription:@"This spell turns the flesh of a willing creature you touch as hard as stone. Until the spell ends, the target has resistance to nonmagical bludgeoning, piercing, and slashing damage."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Suggestion"
                            level:@2
                    schoolOfMagic:enchantment
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V, M (a snake's tongue and either a bit of honeycomb or a drop of sweet oil)"
                         duration:@"Concentration, up to 8 hours"
                 spellDescription:@"You suggest a course of activity (limited to a sentence or two) and magically influence a creature you can see within range that can hear and understand you. Creatures that can’t be charmed are immune to this effect. The suggestion must be worded in such a manner as to make the course of action sound reasonable. Asking the creature to stab itself, throw itself onto a spear, immolate itself, or do some other obviously harmful act ends the spell.\n    The target must make a Wisdom saving throw. On a failed save, it pursues the course of action you described to the best of its ability. The suggested course of action can continue for the entire duration. If the suggested activity can be completed in a shorter time, the spell ends when the subject finishes what it was asked to do.\n    You can also specify conditions that will trigger a special activity during the duration. For example, you might suggest that a knight give her warhorse to the first beggar she meets. If the condition isn’t met before the spell expires, the activity isn’t performed.\n    If you or any of your companions damage the target, the spell ends."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Sunburst"
                            level:@8
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"150 feet"
                       components:@"V, S, M (a fire and a piece of sunstone)"
                         duration:@"Instantaneous"
                 spellDescription:@"Brilliant sunlight flashes in a 60-foot radius centered on a point you choose within range. Each creature in that light must make a Constitution saving throw. On a failed save, a creature takes 12d6 radiant damage and is blinded for 1 minute. On a successful save, it takes half as much damage and isn’t blinded by this spell. Undead and oozes have disadvantage on this saving throw.\n    A creature blinded by this spell makes another Constitution saving throw at the end of each of its turns. On a successful save, it is no longer blinded.\n    This spell dispels any darkness in its area that was created by a spell."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Teleport"
                            level:@7
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"10 feet"
                       components:@"V"
                         duration:@"Instantaneous"
                 spellDescription:@"This spell instantly transports you and up to eight willing creatures of your choice that you can see within range, or a single object that you can see within range, to a destination you select. If you target an object, it must be able to fit entirely inside a 10-foot cube, and it can’t be held or carried by an unwilling creature.\n    The destination you choose must be known to you, and it must be on the same plane of existence as you. Your familiarity with the destination determines whether you arrive there successfully. The DM rolls d100 and consults the table.\n    Familiarity. “Permanent circle” means a permanent teleportation circle whose sigil sequence you know. “Associated object” means that you possess an object taken from the desired destination within the last six months, such as a book from a wizard’s library, bed linen from a royal suite, or a chunk of marble from a lich’s secret tomb.\n    “Very familiar” is a place you have been very often, a place you have carefully studied, or a place you can see when you cast the spell. “Seen casually” is someplace you have seen more than once but with which you aren’t very familiar. “Viewed once” is a place you have seen once, possibly using magic. “Description” is a place whose location and appearance you know through someone else’s description, perhaps from a map. \n    “False destination” is a place that doesn’t exist. Perhaps you tried to scry an enemy’s sanctum but instead viewed an illusion, or you are attempting to teleport to a familiar location that no longer exists.\n    On Target. You and your group (or the target object) appear where you want to.\n    Off Target. You and your group (or the target object) appear a random distance away from the destination in a random direction. Distance off target is 1d10 × 1d10 percent of the distance that was to be traveled. For example, if you tried to travel 120 miles, landed off target, and rolled a 5 and 3 on the two d10s, then you would be off target by 15 percent, or 18 miles. The DM determines the direction off target randomly by rolling a d8 and designating 1 as north, 2 as northeast, 3 as east, and so on around the points of the compass. If you were teleporting to a coastal city and wound up 18 miles out at sea, you could be in trouble.\n    Similar Area. You and your group (or the target object) wind up in a different area that’s visually or thematically similar to the target area. If you are heading for your home laboratory, for example, you might wind up in another wizard’s laboratory or in an alchemical supply shop that has many of the same tools and implements as your laboratory. Generally, you appear in the closest similar place, but since the spell has no range limit, you could conceivably wind up anywhere on the plane.\n    Mishap. The spell’s unpredictable magic results in a difficult journey. Each teleporting creature (or the target object) takes 3d10 force damage, and the DM rerolls on the table to see where you wind up (multiple mishaps can occur, dealing damage each time).\n\nFamiliarity - Permanent circle\n  Mishap:      --\n  Similar Area: --\n  Off Target:   --\n  On Target:   01-100\n\nFamiliarity - Associated object\n  Mishap:      --\n  Similar Area: --\n  Off Target:   --\n  On Target:   01-100\n\nFamiliarity - Very familiar\n  Mishap:      01-05\n  Similar Area: 06-13\n  Off Target:   14-24\n  On Target:   25-100\n\nFamiliarity - Seen casually\n  Mishap:      01-33\n  Similar Area: 34-43\n  Off Target:   44-53\n  On Target:   54-100\n\nFamiliarity - Viewed Once\n  Mishap:      01-43\n  Similar Area: 44-53\n  Off Target:   54-73\n  On Target:   74-100\n\nFamiliarity - Description\n  Mishap:      01-43\n  Similar Area: 44-53\n  Off Target:   54-73\n  On Target:   74-100\n\nFamiliarity - False destination\n  Mishap:      01-50\n  Similar Area: 51-100\n  Off Target:   --\n  On Target:   --"];

    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Thaumaturgy"
                            level:@0
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"30 feet"
                       components:@"V"
                         duration:@"Up to 1 minute"
                 spellDescription:@"You manifest a minor wonder, a sign of supernatural power, within range. You create one of the following magical effects within range:\n• Your voice booms up to three times as loud as normal for 1 minute.\n• You cause flames to flicker, brighten, dim, or change color for 1 minute.\n• You cause harmless tremors in the ground for 1 minute.\n• You create an instantaneous sound that originates from a point of your choice within range, such as a rumble of thunder, the cry of a raven, or ominous whispers.\n• You instantaneously cause an unlocked door or window to fly open or slam shut.\n• You alter the appearance of your eyes for 1 minute.\nIf you cast this spell multiple times, you can have up to three of its 1-minute effects active at a time, and you can dismiss such an effect as an action."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Thunderwave"
                            level:@1
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self (15-foot cube)"
                       components:@"V, S"
                         duration:@"Instantaneous"
                 spellDescription:@"A wave of thunderous force sweeps out from you. Each creature in a 15-foot cube originating from you must make a Constitution saving throw. On a failed save, a creature takes 2d8 thunder damage and is pushed 10 feet away from you. On a successful save, the creature takes half as much damage and isn’t pushed.\n    In addition, unsecured objects that are completely within the area of effect are automatically pushed 10 feet away from you by the spell’s effect, and the spell emits a thunderous boom audible out to 300 feet.\n    At Higher Levels. When you cast this spell using a spell slot of 2nd level or higher, the damage increases by 1d8 for each slot level above 1st."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Time Stop"
                            level:@9
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V"
                         duration:@"Instantaneous"
                 spellDescription:@"You briefly stop the flow of time for everyone but yourself. No time passes for other creatures, while you take 1d4 + 1 turns in a row, during which you can use actions and move as normal.\n    This spell ends if one of the actions you use during this period, or any effects that you create during this period, affects a creature other than you or an object being worn or carried by someone other than you. In addition, the spell ends if you move to a place more than 1,000 feet from the location where you cast it."];
    
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
    
# pragma mark - Spells W
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Wall of Fire"
                            level:@4
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"120 feet"
                       components:@"V, S, M (a small piece of phosphorous"
                         duration:@"Concentration, up to 1 minute"
                 spellDescription:@"You create a wall of fire on a solid surface within range. You can make the wall up to 60 feet long, 20 feet high, and 1 foot thick, or a ringed wall up to 20 feet in diameter, 20 feet high, and 1 foot thick. The wall is opaque and lasts for the duration.\n    When the wall appears, each creature within its area must make a Dexterity saving throw. On a failed save, a creature takes 5d8 fire damage, or half as much damage on a successful save.\n    One side of the wall, selected by you when you cast this spell, deals 5d8 fire damage to each creature that ends its turn within 10 feet of that side or inside the wall. A creature takes the same damage when it enters the wall for the first time on a turn or ends its turn there. The other side of the wall deals no damage.\n    At Higher Levels. When you cast this spell using a spell slot of 5th level or higher, the damage increases by 1d8 for each slot level above 4th."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Wall of Stone"
                            level:@5
                    schoolOfMagic:evocation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"120 feet"
                       components:@"V, S, M (a small block of granite)"
                         duration:@"Concentration, up to 10 minutes"
                 spellDescription:@"A nonmagical wall of solid stone springs into existence at a point you choose within range. The wall is 6 inches thick and is composed of ten 10-foot-by-10-foot panels. Each panel must be contiguous with at least one other panel. Alternatively, you can create 10-foot-by-20-foot panels that are only 3 inches thick.\n    If the wall cuts through a creature’s space when it appears, the creature is pushed to one side of the wall (your choice). If a creature would be surrounded on all sides by the wall (or the wall and another solid surface), that creature can make a Dexterity saving throw. On a success, it can use its reaction to move up to its speed so that it is no longer enclosed by the wall.\n    The wall can have any shape you desire, though it can’t occupy the same space as a creature or object. The wall doesn’t need to be vertical or rest on any firm foundation. It must, however, merge with and be solidly supported by existing stone. Thus, you can use this spell to bridge a chasm or create a ramp.\n    If you create a span greater than 20 feet in length, you must halve the size of each panel to create supports. You can crudely shape the wall to create crenellations, battlements, and so on.\n    The wall is an object made of stone that can be damaged and thus breached. Each panel has AC 15 and 30 hit points per inch of thickness. Reducing a panel to 0 hit points destroys it and might cause connected panels to collapse at the DM’s discretion.\n    If you maintain your concentration on this spell for its whole duration, the wall becomes permanent and can’t be dispelled. Otherwise, the wall disappears when the spell ends."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Warding Bond"
                            level:@2
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[cleric]
                      castingTime:@"1 action"
                            range:@"Touch"
                       components:@"V, S, M (a pair of platinum rings worth at least 50 gp each, which you and the target must wear for the duration)"
                         duration:@"1 hour"
                 spellDescription:@"This spell wards a willing creature you touch and creates a mystic connection between you and the target until the spell ends. While the target is within 60 feet of you, it gains a +1 bonus to AC and saving throws, and it has resistance to all damage. Also, each time it takes damage, you take the same amount of damage.\n    The spell ends if you drop to 0 hit points or if you and the target become separated by more than 60 feet. It also ends if the spell is cast again on either of the connected creatures. You can also dismiss the spell as an action."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Web"
                            level:@2
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S, M (a bit of spiderweb)"
                         duration:@"Concentration, up to 1 hour"
                 spellDescription:@"You conjure a mass of thick, sticky webbing at a point of your choice within range. The webs fill a 20-foot cube from that point for the duration. The webs are difficult terrain and lightly obscure their area.\n    If the webs aren’t anchored between two solid masses (such as walls or trees) or layered across a floor, wall, or ceiling, the conjured web collapses on itself, and the spell ends at the start of your next turn. Webs layered over a flat surface have a depth of 5 feet.\n    Each creature that starts its turn in the webs or that enters them during its turn must make a Dexterity saving throw. On a failed save, the creature is restrained as long as it remains in the webs or until it breaks free.\n    A creature restrained by the webs can use its action to make a Strength check against your spell save DC. If it succeeds, it is no longer restrained.\n    The webs are flammable. Any 5-foot cube of webs exposed to fire burns away in 1 round, dealing 2d4 fire damage to any creature that starts its turn in the fire."];
    
# pragma mark - Barry's PH spells
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Blade Ward"
                            level:@0
                    schoolOfMagic:abjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"Self"
                       components:@"V, S"
                         duration:@"1 round"
                 spellDescription:@"You extend your hand and trace a sigil of warding in the air. Until the end of your next turn, you have resistance against bludgeoning, piercing, and slashing damage dealt by weapon attacks."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Feather Fall"
                            level:@1
                    schoolOfMagic:transmutation
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 reaction, which you take when you or a creature within 60 feet of you falls"
                            range:@"60 feet"
                       components:@"V, M (a small feather or piece of down)"
                         duration:@"1 minute"
                 spellDescription:@"Choose up to five falling creatures within range. A falling creature's rate of descent slows to 60 feet per round until the spell ends. If the creature lands before the spell ends, it takes no falling damage and can land on its feet, and the spell ends for that creature."];
    
    [Spell createSpellWithContext:self.managedObjectContext
                             name:@"Unseen Servant - (ritual)"
                            level:@1
                    schoolOfMagic:conjuration
                   inSpellLibrary:starterSetSpellLibrary
                forAllowedClasses:@[wizard]
                      castingTime:@"1 action"
                            range:@"60 feet"
                       components:@"V, S, M (a piece of string and a bit of wood)"
                         duration:@"1 hour"
                 spellDescription:@"This spell creates an invisible, mindless, shapeless force that perfroms simple tasks at your command until the spell ends. The servant springs into existence in an unoccupied space on the ground within range. It has AC 10, 1 hit point, and a Strength of 2, and it can't attack. If it drop to 0 hit points, the spell ends.\n    Once on each of your turns as a bonus action, you can mentally command the servant to move up to 15 feet and interact with an object. The servant can perform simple tasks that a human servant could do, such as fetching things, cleaning, mending, folding clothes, lighting fires, serving food, and pouring wine. Once you give the command, the servant performs the task to the best of its ability until it completes the task, then waits for your next command.\n    If you command the servant to perform a task that would move it more than 60 feet away from you, the spell ends."];
    
    [self.starterSetDataManager saveContext];
}



@end
