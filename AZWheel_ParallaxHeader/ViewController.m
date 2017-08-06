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
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, ParallaxHeaderDelegate> {
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

    
}

#pragma mark - uitableview datasource & delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    NSString *appendStr = nil;
    if (indexPath.row % 2 == 0) {
        appendStr = @"azz";
    } else {
        appendStr = @"wzt";
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Line %ld  -- %@", (long)indexPath.row, appendStr];
    cell.backgroundColor = [UIColor colorWithRed:246/255.f green:238/255.f blue:226/255.f alpha:1];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        UIImage *image = [UIImage imageNamed:@"azz1.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGFloat imageW = image.size.width;
        CGFloat imageH = image.size.height;
        //    imageView.frame = CGRectMake(0, 0, _mWidth, imageH/imageW*_mWidth);
        imageView.frame = CGRectMake(0, 20, imageW/imageH*(300-20), (300-20));
        imageView.center = CGPointMake(_mWidth/2, imageView.center.y);
        imageView.alpha = 1;
        
        tableView.parallaxHeader.view = imageView;
        tableView.parallaxHeader.height = 300;
        tableView.parallaxHeader.minimumHeight = 100;
        tableView.parallaxHeader.delegate = self;
    } else {
        JellyHeader *jellyHeader = [[JellyHeader alloc] initWithFrame:CGRectMake(0,0, _mWidth, 550)];
        jellyHeader.bottomColor = [UIColor colorWithRed:246/255.f green:238/255.f blue:226/255.f alpha:1];
        tableView.parallaxHeader.height = 550;
        tableView.parallaxHeader.minimumHeight = 64;
        tableView.parallaxHeader.view = jellyHeader;
        tableView.parallaxHeader.delegate = jellyHeader;
        tableView.parallaxHeader.bgImage = [UIImage imageNamed:@"wzt.jpg"];

    }
}

#pragma mark - ParallaxHeaderDelegate
-(void)parallaxHeaderDidScroll:(ParallaxHeader *)parallaxHeader progress:(CGFloat)progress {
    CGFloat h = parallaxHeader.view.frame.size.height;
    CGFloat w = parallaxHeader.view.frame.size.width;
    CGFloat currentH = parallaxHeader.frame.size.height;
    parallaxHeader.view.frame = CGRectMake(0, 20, w/h*(currentH-20), (currentH - 20));
    parallaxHeader.view.center = CGPointMake(parallaxHeader.center.x, (currentH + 20)/2);
    
}
@end
