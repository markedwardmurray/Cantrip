//
//  SchoolOfMagic+Methods.m
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "SchoolOfMagic+Methods.h"

@implementation SchoolOfMagic (Methods)

+ (instancetype)createSchoolOfMagicWithContext:(NSManagedObjectContext *)context
                                          name:(NSString *)name
{
    SchoolOfMagic *newSchoolOfMagic =
            [NSEntityDescription insertNewObjectForEntityForName:@"SchoolOfMagic"
                                          inManagedObjectContext:context];
    newSchoolOfMagic.name = name;
    return newSchoolOfMagic;
}

@end
