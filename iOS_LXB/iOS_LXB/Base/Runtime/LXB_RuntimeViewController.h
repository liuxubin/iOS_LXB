//
//  LXB_RuntimeViewController.h
//  iOS_LXB
//
//  Created by 穗金所 on 2018/12/25.
//  Copyright © 2018年 kodbin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LXB_RuntimeViewControllerDelegate <NSObject>

- (void)protocolMethodTest;

@end

@interface LXB_RuntimeViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
