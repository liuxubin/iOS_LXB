//
//  LXB_RedPacketView.h
//  iOS_LXB
//
//  Created by 穗金所 on 2018/12/21.
//  Copyright © 2018年 kodbin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXB_RedPacketView : UIView

- (void)startRedPackerts;//开始
- (void)endAnimation;//结束
@property (nonatomic,strong)UIView *touchView;

@end

NS_ASSUME_NONNULL_END
