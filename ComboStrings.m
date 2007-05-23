//
//  ComboStrings.m
//  RegexTester
//
//  Created by Simon Stiefel on 27.02.07.
//  Copyright 2007 stiefels.net. All rights reserved.
//

#import "ComboStrings.h"

@implementation ComboStrings

- (id) init {
    self = [super init];
    if (self != nil) {
        _comboStrings = [[NSArray array] retain];
        _selectedComboString = [[NSString string] retain];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    _selectedComboString = [[coder decodeObjectForKey:@"selectedComboString"] retain];
    _comboStrings = [[coder decodeObjectForKey:@"comboStrings"] retain];
    return self;
}


- (NSArray *)comboStrings
{
    return _comboStrings;
}

- (void)setComboStrings:(NSArray *)strings
{
    if ([self comboStrings] != strings) {
        [[self comboStrings] release];
        _comboStrings = [strings retain];
    }
}

- (void)addComboString:(NSString *)newString
{
    [self willChangeValueForKey:@"comboStrings"];
    if (! [[self comboStrings] containsObject:newString]) {
        [self setComboStrings:[[self comboStrings] arrayByAddingObject:newString]];
    }
    [self didChangeValueForKey:@"comboStrings"];
}

- (void)clearComboStrings
{
    [self willChangeValueForKey:@"comboStrings"];
    
    [self setComboStrings:[NSArray array]];
    [self didChangeValueForKey:@"comboStrings"];
}

- (NSString *)selectedComboString
{
    return _selectedComboString;
}

- (void)setSelectedComboString:(NSString *)selectedString
{
    [[self selectedComboString] release];
    _selectedComboString = [selectedString copy];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:[self selectedComboString] forKey:@"selectedComboString"];
    [coder encodeObject:[self comboStrings] forKey:@"comboStrings"];
    return;
}

- (unsigned int)countOfComboStrings {
    return [[self comboStrings] count];
}

- (NSString *)objectInComboStringsAtIndex:(unsigned int)index {
    return [[self comboStrings] objectAtIndex:index];
}


@end
