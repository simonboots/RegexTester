/* TrafficLightIndicator */

#import <Cocoa/Cocoa.h>

@interface TrafficLightIndicator : NSView
{
    NSColor *trueColor;
    NSColor *falseColor;
    NSColor *inactiveColor;
    
    BOOL status;
}

- (void)setTrueColor:(NSColor *)color;
- (NSColor *)trueColor;
- (void)setFalseColor:(NSColor *)color;
- (NSColor *)falseColor;
- (void)setInactiveColor:(NSColor *)color;
- (NSColor *)inactiveColor;

- (void)setIndicatorStatus:(BOOL)newstatus;
- (BOOL)indicatorStatus;
- (void)toggleIndicatorStatus;

@end
