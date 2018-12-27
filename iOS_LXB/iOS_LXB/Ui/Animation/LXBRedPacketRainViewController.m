//
//  LXBRedPacketRainViewController.m
//  iOS_LXB
//
//  Created by 穗金所 on 2018/12/21.
//  Copyright © 2018年 kodbin. All rights reserved.
//

#import "LXBRedPacketRainViewController.h"
#import "LXB_RedPacketView.h"

@interface LXBRedPacketRainViewController ()

@property (nonatomic,strong)LXB_RedPacketView *rv;

@end

@implementation LXBRedPacketRainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.rv endAnimation];
        
    });
    
    
}


- (IBAction)starRedPacketAction:(id)sender {
    
    self.rv  = [LXB_RedPacketView new];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.rv.touchView];
    [self.rv startRedPackerts];
    
}

- (IBAction)endRedPacketAction:(id)sender {
    
    [self.rv endAnimation];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
