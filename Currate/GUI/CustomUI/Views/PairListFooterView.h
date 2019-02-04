//
//  PairListFooterView.h
//  Currate
//
//  Created by Eugene Vegner on 2/4/19.
//  Copyright © 2019 Eugene Vegner. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PairListFooterView;
@protocol PairListFooterViewDelegate <NSObject>
- (void)didPressInfo;
@end

@interface PairListFooterView : UIView

@property (nonatomic, weak) id<PairListFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
