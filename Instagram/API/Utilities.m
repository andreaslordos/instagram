//
//  Utilities.m
//  Instagram
//
//  Created by Andreas Lordos on 6/27/22.
//

#import "Utilities.h"

@implementation Utilities

+ (void)createSimpleAlert:(NSString *)alertTitle desc:(NSString *)alertText vc:(UIViewController *)vc {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                               message:alertText
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    
    // create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    
    [alert addAction:okAction];
    [vc presentViewController:alert animated:YES completion:^{
    }];
}

+ (BOOL)checkIfEmpty:(NSString *)text fieldName:(NSString *)fieldName vc:(UIViewController *)vc {
    NSString *alertTitle = [@"Empty " stringByAppendingString:[fieldName lowercaseString]];
    NSString *alertText = [fieldName stringByAppendingString:@" cannot be empty."];
    
    if ([text isEqual:@""]) {
        [self createSimpleAlert:alertTitle desc:alertText vc:vc];
        return YES;
    }
    else {
        return NO;
    }
}

@end
