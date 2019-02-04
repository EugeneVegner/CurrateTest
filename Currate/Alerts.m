//
//  Alerts.m
//  Currate
//
//  Created by Eugene Vegner on 2/5/19.
//  Copyright © 2019 Eugene Vegner. All rights reserved.
//

#import "Alerts.h"
#import <UIKit/UIKit.h>

@implementation Alerts

+ (void)showErrorMessage:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alert addAction:actionOk];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alert animated:YES completion:nil];

    
}

@end
