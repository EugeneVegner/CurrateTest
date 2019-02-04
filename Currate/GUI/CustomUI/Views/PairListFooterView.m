//
//  PairListFooterView.m
//  Currate
//
//  Created by Eugene Vegner on 2/4/19.
//  Copyright © 2019 Eugene Vegner. All rights reserved.
//

#import "PairListFooterView.h"

@interface PairListFooterView ()
@property (nonatomic, strong) UIButton *button;

@end

@implementation PairListFooterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.button = [[UIButton alloc] init];
        [self.button setTitle:@"Get Info" forState:UIControlStateNormal];
        [self.button setBackgroundColor:[UIColor orangeColor]];
        [self.button setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.button addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        [self configureTitleConstraints];
    }
    return self;
}    

- (void)press:(UIButton *)sender {
    if (_delegate) {
        [_delegate didPressInfo];
    }
}

- (void)configureTitleConstraints {
    
//    let horizontalConstraint = NSLayoutConstraint(item: newView,
//                                                  attribute: .CenterX,
//                                                  relatedBy: .Equal,
//                                                  toItem: view,
//                                                  attribute: .CenterX,
//                                                  multiplier: 1,
//                                                  constant: 0)
//    view.addConstraint(horizontalConstraint)
//    let verticalConstraint = NSLayoutConstraint(item: newView,
//                                                attribute: .CenterY,
//                                                relatedBy: .Equal,
//                                                toItem: view,
//                                                attribute: .CenterY,
//                                                multiplier: 1,
//                                                constant: 0)
//    view.addConstraint(verticalConstraint)

    
//    NSLayoutConstraint * widthConstraint = newView.widthAnchor.constraintEqualToAnchor(nil, constant: 100)
//    NSLayoutConstraint * heightConstraint = newView.heightAnchor.constraintEqualToAnchor(nil, constant: 100)

    
    NSLayoutConstraint *centerX =[NSLayoutConstraint
                                   constraintWithItem:_button
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeCenterX
                                   multiplier:1.0f
                                   constant:0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint
                                   constraintWithItem:_button
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self
                                   attribute:NSLayoutAttributeCenterY
                                   multiplier:1.0f
                                   constant:0];
    
    NSLayoutConstraint *height = [NSLayoutConstraint
                                  constraintWithItem:_button
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:0
                                  constant:38];
    
    NSLayoutConstraint *width = [NSLayoutConstraint
                                  constraintWithItem:_button
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:0
                                  constant:160];

    
    [self addConstraint:centerX];
    [self addConstraint:centerY];
    [self addConstraint:width];
    [self addConstraint:height];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
