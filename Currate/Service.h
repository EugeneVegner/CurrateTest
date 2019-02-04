//
//  Service.h
//  Currate
//
//  Created by Eugene Vegner on 2/4/19.
//  Copyright © 2019 Eugene Vegner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pair.h"

NS_ASSUME_NONNULL_BEGIN


@interface Service : NSObject

- (void)getCurrencyList:(void (^)(NSArray<Pair *> * _Nullable list))block;
- (void)getRatesByPairs:(NSArray<NSString*> *)keys success:(void (^)(NSArray<Pair *> * _Nullable list))block;

@end

NS_ASSUME_NONNULL_END
