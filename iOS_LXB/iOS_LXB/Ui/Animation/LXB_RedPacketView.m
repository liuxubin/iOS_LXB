//
//  LXB_RedPacketView.m
//  iOS_LXB
//
//  Created by 穗金所 on 2018/12/21.
//  Copyright © 2018年 kodbin. All rights reserved.
//

#import "LXB_RedPacketView.h"

@interface LXB_RedPacketView ()

@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic,strong)CALayer *moveLayer;

@end

@implementation LXB_RedPacketView

- (UIView *)touchView{
    if (!_touchView) {
        _touchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        _touchView.backgroundColor = [UIColor yellowColor];
        UITapGestureRecognizer *gestu = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickRed:)];
        [_touchView addGestureRecognizer:gestu];
    }
    return _touchView;
}

- (void)startRedPackerts
{
    //[self touchView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1/4.0) target:self selector:@selector(showRain) userInfo:nil repeats:YES];
    //[self.timer invalidate];
}

- (void)showRain
{
    UIImageView * imageV = [UIImageView new];
    imageV.image = [UIImage imageNamed:@"hongbao-2"];
    imageV.frame = CGRectMake(0, 0, 44 , 62.5 );
    
    self.moveLayer = [CALayer new];
    self.moveLayer.bounds = imageV.frame;
    self.moveLayer.anchorPoint = CGPointMake(0, 0);
    self.moveLayer.position = CGPointMake(0, -62.5 );
    self.moveLayer.contents = (id)imageV.image.CGImage;
    [self.touchView.layer addSublayer:self.moveLayer];
    
    [self addAnimation];
}

- (void)addAnimation
{
    CAKeyframeAnimation * moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue * A = [NSValue valueWithCGPoint:CGPointMake(arc4random() % 414, 0)];
    NSValue * B = [NSValue valueWithCGPoint:CGPointMake(arc4random() % 414, SCREENH_HEIGHT)];
    moveAnimation.values = @[A,B];
    moveAnimation.duration = arc4random() % 200 / 100.0 + 3.5;
    moveAnimation.repeatCount = 1;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.moveLayer addAnimation:moveAnimation forKey:nil];
    
    CAKeyframeAnimation * tranAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D r0 = CATransform3DMakeRotation(M_PI/180 * (arc4random() % 360 ) , 0, 0, -1);
    CATransform3D r1 = CATransform3DMakeRotation(M_PI/180 * (arc4random() % 360 ) , 0, 0, -10);
    tranAnimation.values = @[[NSValue valueWithCATransform3D:r0],[NSValue valueWithCATransform3D:r1]];
    tranAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    tranAnimation.duration = arc4random() % 200 / 100.0 + 3.5;
    //为了避免旋转动画完成后再次回到初始状态。
    [tranAnimation setFillMode:kCAFillModeForwards];
    [tranAnimation setRemovedOnCompletion:NO];
    [self.moveLayer addAnimation:tranAnimation forKey:nil];
}


//结束
- (void)endAnimation
{
    [self.timer invalidate];
    
    for (NSInteger i = 0; i < self.touchView.layer.sublayers.count ; i ++)
    {
        
        CALayer * layer = self.touchView.layer.sublayers[i];
    
        [layer removeAllAnimations];
    }
    
    [self.touchView removeFromSuperview];
    
}


//点击事件
- (void)clickRed:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.touchView];
    for (int i = 0 ; i < self.touchView.layer.sublayers.count ; i ++)
    {
        CALayer * layer = self.touchView.layer.sublayers[i];
        if ([[layer presentationLayer] hitTest:point] != nil)
        {
            NSLog(@"%d",i);
            
            BOOL hasRedPacketd = !(i % 3) ;
            
            //变图
            UIImageView * newPacketIV = [UIImageView new];
            if (hasRedPacketd)
            {
                newPacketIV.image = [UIImage imageNamed:@"hongbao-cc"];
                newPacketIV.frame = CGRectMake(0, 0, 63.5, 74);
            }
            else
            {
                newPacketIV.image = [UIImage imageNamed:@"none"];
                newPacketIV.frame = CGRectMake(0, 0, 45.5, 76.5);
            }
            layer.contents = (id)newPacketIV.image.CGImage;
            
            UIView * alertView = [UIView new];
            alertView.layer.cornerRadius = 5;
            alertView.frame = CGRectMake(point.x - 50, point.y, 100, 30);
            [self.touchView addSubview:alertView];
            
            //显示
            UILabel * label = [UILabel new];
            label.font = [UIFont systemFontOfSize:17];
            
            if (!hasRedPacketd)
            {
                label.text = @"什么也没有";
                label.textColor = [UIColor blueColor];
            }
            else
            {
                NSString * string = [NSString stringWithFormat:@"+%d金币",i];
                NSString * iString = [NSString stringWithFormat:@"%d",i];
                NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:string];
                
                [attributedStr addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:27]
                                      range:NSMakeRange(0, 1)];
                [attributedStr addAttribute:NSFontAttributeName
                                      value:[UIFont fontWithName:@"PingFangTC-Semibold" size:32]
                                      range:NSMakeRange(1, iString.length)];
                [attributedStr addAttribute:NSFontAttributeName
                                      value:[UIFont systemFontOfSize:17]
                                      range:NSMakeRange(1 + iString.length, 2)];
                label.attributedText = attributedStr;
                label.textColor = RGBA(255,223,14, 1);
            }
            
            [alertView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(alertView.mas_centerX);
                make.centerY.equalTo(alertView.mas_centerY);
            }];
            
            [UIView animateWithDuration:1 animations:^{
                alertView.alpha = 0;
                alertView.frame = CGRectMake(point.x- 50, point.y - 100, 100, 30);
            } completion:^(BOOL finished) {
                [alertView removeFromSuperview];
            }];
        }
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
