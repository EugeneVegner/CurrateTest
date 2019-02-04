//
//  PairTableViewCell.m
//  Currate
//
//  Created by Eugene Vegner on 2/4/19.
//  Copyright © 2019 Eugene Vegner. All rights reserved.
//

#import "PairTableViewCell.h"

@implementation PairTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.titleLabel];
        [self configureTitleConstraints];
        
        
        if (reuseIdentifier == kPairListCellIdentifier) {
            self.checkBox = [[UISwitch alloc] init];
            [self.checkBox setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.checkBox setFrame:CGRectMake(0, 21, self.contentView.frame.size.width, 20)];
            [self.checkBox addTarget:self action:@selector(pressSwitch:) forControlEvents:UIControlEventValueChanged];
            [self.contentView addSubview:self.checkBox];
            [self configureCheckBoxConstraints];
            
            
        } else {
            self.infoLabel = [[UILabel alloc] init];
            [self.infoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.infoLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
            [self.contentView addSubview:self.infoLabel];
            [self configureInfoLabelConstraints];
        }
    }
    return self;
}

// MARK: - Constraints

- (void)configureTitleConstraints {
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:_titleLabel
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.contentView
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:60];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:_titleLabel
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.contentView
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:20.f];
    
    NSLayoutConstraint *height = [NSLayoutConstraint
                                  constraintWithItem:_titleLabel
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                                  attribute:NSLayoutAttributeHeight
                                  multiplier:1.0f
                                  constant:0];
    
    [self.contentView addConstraint:trailing];
    [self.contentView addConstraint:leading];
    [self.contentView addConstraint:height];
}

- (void)configureCheckBoxConstraints {
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint
                                   constraintWithItem:_checkBox
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.contentView
                                   attribute:NSLayoutAttributeCenterY
                                   multiplier:1.0f
                                   constant:0];

    
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:_checkBox
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.contentView
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:-20.f];
    
    [self.contentView addConstraint:trailing];
    [self.contentView addConstraint:centerY];
}


- (void)configureInfoLabelConstraints {
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint
                                   constraintWithItem:_infoLabel
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.contentView
                                   attribute:NSLayoutAttributeCenterY
                                   multiplier:1.0f
                                   constant:0];
    
    
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:_infoLabel
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.contentView
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:-20.f];
    
    NSLayoutConstraint *height = [NSLayoutConstraint
                                  constraintWithItem:_infoLabel
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:self.contentView
                                  attribute:NSLayoutAttributeHeight
                                  multiplier:1.0f
                                  constant:0];
    
    [self.contentView addConstraint:trailing];
    [self.contentView addConstraint:centerY];
    [self.contentView addConstraint:height];
}



- (void)pressSwitch:(UISwitch *)sender {
    if (_checkBoxDelegate) {
        [_checkBoxDelegate didSwitchCell:self selected:sender.on atIndexPath:self.indexPath];
    }
}

@end
