//
//  ViewController.m
//  AZWheel_ParallaxHeader
//
//  Created by 阿曌 on 17/8/6.
//  Copyright © 2017年 阿曌. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+ParallaxHeader.h"
#import "JellyHeader.h"
#import "TableTableViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource> {
    CGFloat _mWidth;
    CGFloat _mHeight;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mWidth = self.view.bounds.size.width;
    _mHeight = self.view.bounds.size.height;
    
    UITableView* table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];

    [self showWZT:table];
}

#pragma mark - uitableview datasource & delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    NSString *appendStr = @"present";
    cell.textLabel.text = [NSString stringWithFormat:@"Line %ld  -- %@", (long)indexPath.row, appendStr];
    cell.backgroundColor = [UIColor colorWithRed:246/255.f green:238/255.f blue:226/255.f alpha:1];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController* tableVC = [[TableTableViewController alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:tableVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showWZT:(UITableView*)tableView {
    JellyHeader *jellyHeader = [[JellyHeader alloc] initWithFrame:CGRectMake(0,0, _mWidth, 550)];
    jellyHeader.bottomColor = [UIColor colorWithRed:246/255.f green:238/255.f blue:226/255.f alpha:1];
    tableView.parallaxHeader.height = 550;
    tableView.parallaxHeader.minimumHeight = 164;
    tableView.parallaxHeader.view = jellyHeader;
    tableView.parallaxHeader.delegate = jellyHeader;
    tableView.parallaxHeader.bgImage = [UIImage imageNamed:@"wzt.jpg"];
}

@end
