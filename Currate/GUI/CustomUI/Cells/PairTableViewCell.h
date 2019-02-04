//
//  PairTableViewCell.h
//  Currate
//
//  Created by Eugene Vegner on 2/4/19.
//  Copyright © 2019 Eugene Vegner. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kPairListCellIdentifier = @"PairListCellIdentifier";
static NSString * const kPairInfoCellIdentifier = @"PairInfoCellIdentifier";

NS_ASSUME_NONNULL_BEGIN

@class PairTableViewCell;
@protocol PairTableViewCellCheckedDelegate <NSObject>

- (void)didSwitchCell:(PairTableViewCell *)cell selected:(BOOL)selected atIndexPath:(NSIndexPath *)indexPath;

@end


@interface PairTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UISwitch *checkBox;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<PairTableViewCellCheckedDelegate> checkBoxDelegate;

@end

NS_ASSUME_NONNULL_END
