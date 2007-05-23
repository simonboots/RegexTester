//
//  MyController.m
//  RegexTester
//
//  Created by Simon Stiefel on 27.02.07.
//  Copyright 2007 stiefels.net. All rights reserved.
//

#import "MyController.h"
#import "ComboStrings.h"
#import "TrafficLightIndicator.h"

@implementation MyController

- (id) init {
    self = [super init];
    if (self != nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if ([defaults objectForKey:@"regularexpressions"] != nil && [defaults objectForKey:@"teststrings"] != nil) {
            NSData *regularexpressions = [defaults objectForKey:@"regularexpressions"];
            NSData *teststrings = [defaults objectForKey:@"teststrings"];
            [[self regularExpressions] release];
            [[self testStrings] release];
            [self setRegularExpressions:[NSKeyedUnarchiver unarchiveObjectWithData:regularexpressions]];
            [self setTestStrings:[NSKeyedUnarchiver unarchiveObjectWithData:teststrings]];
        } else {
            _regularExpressions = [[ComboStrings alloc] init];
            _testStrings = [[ComboStrings alloc] init];
        }
        
        // observe selectedComboValue for automatic string validation
        
        [_regularExpressions addObserver:self
                              forKeyPath:@"selectedComboString" 
                                 options:NSKeyValueObservingOptionNew
                                 context:NULL];
        
        [_testStrings addObserver:self
                       forKeyPath:@"selectedComboString"
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
        
        [_testStrings addObserver:self
                       forKeyPath:@"comboStrings"
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
        
    }
    return self;
}

- (void)awakeFromNib
{    
    [_validationInformation setStringValue:@""];
    [self validateString];
}

- (void)validateString
{
    @try {
        NSPredicate *validation = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", [[self regularExpressions] selectedComboString]];
        
        // test cuurently selected string
        if ([validation evaluateWithObject:[[self testStrings] selectedComboString]]) {
            [_currenttrafficlight setIndicatorStatus:true];
        } else {
            [_currenttrafficlight setIndicatorStatus:false];
        }
        
        // test saved strings
        if ([[[[self testStrings] comboStrings] filteredArrayUsingPredicate:validation] count] == [[[self testStrings] comboStrings] count] &&
            [[[self testStrings] comboStrings] count] != 0) {
            [_savedtrafficlight setIndicatorStatus:true];
        } else {
            [_savedtrafficlight setIndicatorStatus:false];
        }
        
    }
    @catch (NSException *exception) {
        [_validationInformation setStringValue:@"Invalid Regular Expression!"];
        [_currenttrafficlight setIndicatorStatus:false];
        [_savedtrafficlight setIndicatorStatus:false];
        return;
    }
    
    [_validationInformation setStringValue:@""];
}

#pragma mark Menu Actions

- (IBAction)clearRegularExpressions:(id)sender
{
    [_regularExpressions clearComboStrings];
    
}

- (IBAction)clearTestStrings:(id)sender
{
    [_testStrings clearComboStrings];
}

#pragma mark KVO observing methods

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object 
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ((object == _regularExpressions || object == _testStrings) &&
        ([keyPath isEqualToString:@"selectedComboString"] || [keyPath isEqualToString:@"comboStrings"])) {
        [self validateString];
    }
}

#pragma mark NSApp delegate methods

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *regularexpressions = [NSKeyedArchiver archivedDataWithRootObject:[self regularExpressions]];
    NSData *teststrings = [NSKeyedArchiver archivedDataWithRootObject:[self testStrings]];
    [defaults setObject:regularexpressions forKey:@"regularexpressions"];
    [defaults setObject:teststrings forKey:@"teststrings"];
}

#pragma mark ComboStrings getters and setters

- (ComboStrings *)regularExpressions
{
    return _regularExpressions;
}

- (ComboStrings *)testStrings
{
    return _testStrings;
}

- (void)setRegularExpressions:(ComboStrings *)regularExpressions
{
    if ([self regularExpressions] != regularExpressions) {
        [[self regularExpressions] release];
        _regularExpressions = [regularExpressions retain];
    }
}

- (void)setTestStrings:(ComboStrings *)testStrings
{
    if ([self testStrings] != testStrings) {
        [[self testStrings] release];
        _testStrings = [testStrings retain];
    }
}


@end
