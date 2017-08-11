//
//  TableTableViewController.m
//  AZWheel_ParallaxHeader
//
//  Created by cocozzhang on 2017/8/11.
//  Copyright © 2017年 阿曌. All rights reserved.
//

#import "TableTableViewController.h"
#import "UIScrollView+ParallaxHeader.h"
@interface TableTableViewController () <UITableViewDelegate, UITableViewDataSource, ParallaxHeaderDelegate> {
    CGFloat _mWidth;
    CGFloat _mHeight;

}
@property(nonatomic)CGFloat minimumHeight;
@end

@implementation TableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mWidth = self.view.bounds.size.width;
    _mHeight = self.view.bounds.size.height;
    
    //导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    UITableView* table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    
    [self showAZZ:table];
    

}

- (void)showAZZ:(UITableView*)tableView {
    UIImage *image = [UIImage imageNamed:@"azz1.png"];
    UIButton *imageView = [[UIButton alloc] init];
    [imageView setBackgroundImage:image forState:UIControlStateNormal];
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    //    imageView.frame = CGRectMake(0, 0, _mWidth, imageH/imageW*_mWidth);
    imageView.frame = CGRectMake(0, 20, imageW/imageH*(300-20), (300-20));
    imageView.center = CGPointMake(_mWidth/2, imageView.center.y);
    imageView.alpha = 1;
    [imageView addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    tableView.parallaxHeader.view = imageView;
    tableView.parallaxHeader.maxHeight = 300;
    tableView.parallaxHeader.minimumHeight = self.minimumHeight ? : 100;
    tableView.parallaxHeader.delegate = self;
}

- (void)click {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - ParallaxHeaderDelegate
-(void)parallaxHeaderDidScroll:(ParallaxHeader *)parallaxHeader progress:(CGFloat)progress {
    CGFloat h = parallaxHeader.view.frame.size.height;
    CGFloat w = parallaxHeader.view.frame.size.width;
    CGFloat currentH = parallaxHeader.frame.size.height;
    parallaxHeader.view.frame = CGRectMake(0, 20, w/h*(currentH-20), (currentH - 20));
    parallaxHeader.view.center = CGPointMake(parallaxHeader.center.x, (currentH + 20)/2);
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //导航栏默认会给tableView加64的inset
    UIEdgeInsets inset = tableView.contentInset;
    inset.top = 300;
    tableView.contentInset = inset;
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableCell"];
        
        cell.backgroundColor = [UIColor colorWithRed:246/255.f green:238/255.f blue:226/255.f alpha:1];
    }
    NSString *appendStr = @"push";
    cell.textLabel.text = [NSString stringWithFormat:@"Line %ld  -- %@", (long)indexPath.row, appendStr];
    cell.backgroundColor = [UIColor colorWithRed:246/255.f green:238/255.f blue:226/255.f alpha:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TableTableViewController* tableVC = [[TableTableViewController alloc] init];
    tableVC.minimumHeight = 64;
    [self.navigationController pushViewController:tableVC animated:YES];
}
@end
