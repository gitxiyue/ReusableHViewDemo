//
//  ViewController.m
//  ReusableHViewDemo
//
//  Created by xun on 2017/2/16.
//  Copyright © 2017年 xun. All rights reserved.
//

#import "ViewController.h"
#import "ReusableHView.h"
#import "UIImageView+WebCache.h"

#define SCREEN_W ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_H ([[UIScreen mainScreen] bounds].size.height)
@interface ViewController ()<ReusableHDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ReusableHView *rhv = [[ReusableHView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_W, 120) cellSize:CGSizeMake(110, 100) padding:UIEdgeInsetsMake(10, 10, 10, 0) visible:3];
    rhv.reusableDelegate = self;
    [self.view addSubview:rhv];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ReusableHViewDelegate
- (NSInteger)numberOfCellsInReusableHView:(ReusableHView *)view {
    return 10;
}
- (ReusableCell *)reusableHView:(ReusableHView *)view cellAtIndex:(NSInteger)index {
    ReusableCell *cell = [[ReusableCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    cell.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    
    if (index == 0) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img4q.duitang.com/uploads/item/201506/14/20150614214047_BA5Zy.jpeg"] placeholderImage:[UIImage imageNamed:@"123"]];
    }
    else if (index == 1) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img4.duitang.com/uploads/item/201204/30/20120430225540_QiQWJ.thumb.600_0.jpeg"] placeholderImage:[UIImage imageNamed:@"123"]];
    }
    else if (index == 2) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.imgtn.bdimg.com/it/u=3639439277,1341742535&fm=23&gp=0.jpg"] placeholderImage:[UIImage imageNamed:@"123"]];
    }
    else if (index == 3) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://imgwww.heiguang.net/f/2013/0415/20130415032720155.jpg"] placeholderImage:[UIImage imageNamed:@"123"]];
    }
    else if (index == 4) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://imgwww.heiguang.net/f/2013/0415/20130415040312664.jpg"] placeholderImage:[UIImage imageNamed:@"123"]];
    }
    else if (index%3 == 0) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1205/25/c2/11755122_1337938898577.jpg"] placeholderImage:[UIImage imageNamed:@"123"]];
    }
    else {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://image92.360doc.com/DownloadImg/2015/12/1715/63143393_18.jpg"] placeholderImage:[UIImage imageNamed:@"123"]];
    }
    cell.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
    cell.textLabel.text = @"duoduo多多";
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}
- (void)reusableHView:(ReusableHView *)view didSelectAtIndex:(NSInteger)index {
    NSLog(@"=====%zd", index);
}


@end
