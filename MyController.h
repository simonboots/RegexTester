//
//  MyController.h
//  RegexTester
//
//  Created by Simon Stiefel on 27.02.07.
//  Copyright 2007 stiefels.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ComboStrings;


@interface MyController : NSObject {
    ComboStrings *_regularExpressions;
    ComboStrings *_testStrings;
    
    IBOutlet id _currenttrafficlight;
    IBOutlet id _savedtrafficlight;
    IBOutlet id _validationInformation;
}

- (ComboStrings *)regularExpressions;
- (ComboStrings *)testStrings;

- (void)setRegularExpressions:(ComboStrings *)regularExpressions;
- (void)setTestStrings:(ComboStrings *)testStrings;

- (IBAction)clearRegularExpressions:(id)sender;
- (IBAction)clearTestStrings:(id)sender;

- (void)validateString;

@end
