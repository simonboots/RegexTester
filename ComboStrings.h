//
//  ComboStrings.h
//  RegexTester
//
//  Created by Simon Stiefel on 27.02.07.
//  Copyright 2007 stiefels.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ComboStrings : NSObject <NSCoding> {
    NSArray *_comboStrings;
    NSString *_selectedComboString;
}

- (NSArray *)comboStrings;
- (void)setComboStrings:(NSArray *)strings;
- (void)addComboString:(NSString *)newString;
- (void)clearComboStrings;

- (NSString *)selectedComboString;
- (void)setSelectedComboString:(NSString *)selectedComboString;

@end
