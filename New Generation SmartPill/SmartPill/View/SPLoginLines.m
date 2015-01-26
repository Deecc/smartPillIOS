//
//  SPLoginLines.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 18/11/14.
//  Copyright (c) 2014 IFRN - Mobile School. All rights reserved.
//

#import "SPLoginLines.h"

@implementation SPLoginLines

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setNeedsDisplay];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(20, 85)];
    [path addLineToPoint:CGPointMake(110, 85)];
    [path moveToPoint:CGPointMake(205,85)];
    [path addLineToPoint:CGPointMake(300, 85)];
    [path moveToPoint:CGPointMake(20,165)];
    [path addLineToPoint:CGPointMake(147, 165)];
    [path moveToPoint:CGPointMake(175,165)];
    [path addLineToPoint:CGPointMake(300, 165)];
    [path closePath];
    [[UIColor grayColor] setStroke];
    [path stroke];
}
@end
