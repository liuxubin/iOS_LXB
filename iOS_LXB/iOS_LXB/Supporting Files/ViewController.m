//
//  ViewController.m
//  iOS_LXB
//
//  Created by 穗金所 on 2018/12/13.
//  Copyright © 2018年 kodbin. All rights reserved.
//

#import "ViewController.h"
//#import "LXB_ForwardingViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *arrayData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"iOS开发总结";
    
    [self.view addSubview:self.tableView];
}

#pragma mark -dele/data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"home"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"home"];
    }
    
    cell.textLabel.text = self.arrayData[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0://消息转发
            {
//                LXB_ForwardingViewController *vc = [[LXB_ForwardingViewController alloc]init];
//                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - 蓝架子啊
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
        [_arrayData addObjectsFromArray:@[@"消息转发"]];
    }
    return _arrayData;
}


@end
