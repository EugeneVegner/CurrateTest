//
//  Api.h
//  Currate
//
//  Created by Eugene Vegner on 2/4/19.
//  Copyright © 2019 Eugene Vegner. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const kGetRatesMethod = @"rates";
static NSString * const kGetCurrencyListMethod = @"currency_list";

typedef void(^SuccessBlock)(NSDictionary * _Nullable json);

@interface Api : NSObject

- (void)getMethod:(NSString *)method withParameters:(nullable NSDictionary *)params success:(SuccessBlock)block;

@end

NS_ASSUME_NONNULL_END
