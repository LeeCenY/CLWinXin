//
//  CLLongPressBtn.m
//  CLWinXin
//
//  Created by nil on 16/8/5.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLLongPressBtn.h"

@implementation CLLongPressBtn

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        UILongPressGestureRecognizer *longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPressGr.minimumPressDuration = 0.5;
        [self addGestureRecognizer:longPressGr];
    }
    return self;
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress {

    if (self.longPressBtnBlock) {
        self.longPressBtnBlock(self);
    }
}
@end
