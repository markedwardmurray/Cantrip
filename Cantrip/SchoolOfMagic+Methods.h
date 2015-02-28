//
//  SchoolOfMagic+Methods.h
//  Cantrip
//
//  Created by Mark Murray on 2/27/15.
//  Copyright (c) 2015 Mark Edward Murray. All rights reserved.
//

#import "SchoolOfMagic.h"

@interface SchoolOfMagic (Methods)

+ (instancetype)createSchoolOfMagicWithContext:(NSManagedObjectContext *)context
                                          name:(NSString *)name;

@end
