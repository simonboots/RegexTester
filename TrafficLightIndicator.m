#import "TrafficLightIndicator.h"

@implementation TrafficLightIndicator

- (id)initWithFrame:(NSRect)frameRect
{
	if ((self = [super initWithFrame:frameRect]) != nil) {
		[self setTrueColor:[NSColor greenColor]];
        [self setFalseColor:[NSColor redColor]];
        [self setInactiveColor:[NSColor grayColor]];
        [self setIndicatorStatus:YES];
	}
	return self;
}

- (void)drawRect:(NSRect)rect
{
    NSBezierPath *firstCircle = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(5,5,20,20)];
    NSBezierPath *secondCircle = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(35,5,20,20)];

    [[NSColor blackColor] set];
    [firstCircle setLineWidth:1.0];
    [firstCircle stroke];
    
    [secondCircle setLineWidth:1.0];
    [secondCircle stroke];
    
    if (status) {
        [trueColor set];
        [firstCircle fill];
        [inactiveColor set];
        [secondCircle fill];
    } else {
        [inactiveColor set];
        [firstCircle fill];
        [falseColor set];
        [secondCircle fill];
    }
}

- (void)setTrueColor:(NSColor *)color
{
    [color retain];
    [trueColor release];
    trueColor = color;
}

- (NSColor *)trueColor
{
    return trueColor;
}

- (void)setFalseColor:(NSColor *)color
{
    [color retain];
    [falseColor release];
    falseColor = color;
}

- (NSColor *)falseColor
{
    return falseColor;
}

- (void)setInactiveColor:(NSColor *)color
{
    [color retain];
    [inactiveColor release];
    inactiveColor = color;
}

- (NSColor *)inactiveColor
{
    return inactiveColor;
}

- (void)setIndicatorStatus:(BOOL)newstatus
{
    status = newstatus;
    [self setNeedsDisplay:YES];
}

- (BOOL)indicatorStatus
{
    return status;
}

- (void)toggleIndicatorStatus
{
    [self setIndicatorStatus:! status];
}

@end
