//
//  GameSystem.h
//  Cantrip
//
//  Created by Mark Murray on 3/16/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Publication;

@interface GameSystem : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * publisher;
@property (nonatomic, retain) NSSet *publications;
@end

@interface GameSystem (CoreDataGeneratedAccessors)

- (void)addPublicationsObject:(Publication *)value;
- (void)removePublicationsObject:(Publication *)value;
- (void)addPublications:(NSSet *)values;
- (void)removePublications:(NSSet *)values;

@end
