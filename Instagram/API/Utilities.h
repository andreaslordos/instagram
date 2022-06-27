//
//  Utilities.h
//  Instagram
//
//  Created by Andreas Lordos on 6/27/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utilities : NSObject
+ (BOOL)checkIfEmpty:(NSString *)text fieldName:(NSString *)fieldName vc:(UIViewController *)vc;
+ (void)createSimpleAlert:(NSString *)alertTitle desc:(NSString *)alertText vc:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
