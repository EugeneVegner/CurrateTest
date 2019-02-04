//
//  Service.m
//  Currate
//
//  Created by Eugene Vegner on 2/4/19.
//  Copyright © 2019 Eugene Vegner. All rights reserved.
//

#import "Service.h"
#import "Api.h"


static NSString * const kItemCellIdentifier = @"ItemCellIdentifier";


@implementation Service

- (void)getCurrencyList:(void (^)(NSArray<Pair *> * _Nullable list))block {
    
    Api *api = [[Api alloc] init];
    [api getMethod:kGetCurrencyListMethod withParameters:nil success:^(NSDictionary * _Nullable json) {
        if (!json) {
            block(nil);
            return;
        }
        
        NSArray *listData = [json objectForKey:@"data"];
        if (listData && [listData isKindOfClass:[NSArray class]]) {
            NSMutableArray<Pair *> *result = [NSMutableArray array];
            [listData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                Pair *p = [[Pair alloc] init];
                p.title = obj;
                [result addObject:p];
            }];
            block(result);
        }

    }];

    
}


- (void)getRatesByPairs:(NSArray<NSString*> *)keys success:(void (^)(NSArray<Pair *> * _Nullable list))block {
    
    //NSArray<NSString *> *values = [NSArray arrayWithObject:[pairs valueForKey:@"title"]];
    NSString *pairsString = [keys componentsJoinedByString:@","];
    
    Api *api = [[Api alloc] init];
    [api getMethod:kGetRatesMethod withParameters:@{@"pairs": pairsString} success:^(NSDictionary * _Nullable json) {
        if (!json) {
            block(nil);
            return;
        }
        NSDictionary *data = [json objectForKey:@"data"];
        if (data && [data isKindOfClass:[NSDictionary class]]) {
            NSMutableArray<Pair *> *result = [NSMutableArray array];
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                
                //{"EURRUB":"71.3846","USDRUB":"58.059"}
                Pair *p = [[Pair alloc] init];
                p.title = key;
                p.value = [formatter numberFromString:[NSString stringWithFormat:@"%@",obj]];
                [result addObject:p];
            }];
            formatter = nil;
            NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
            block([result sortedArrayUsingDescriptors:@[sd]]);
        }

    }];

    
}






@end
