//
//  ViewController.m
//  JKCreateImage
//
//  Created by 王冲 on 2018/9/7.
//  Copyright © 2018年 JK科技有限公司. All rights reserved.
//

#import "ViewController.h"
/** SDWebImage里面的类*/
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "UIButton+WebCache.h"

#import "JKImageGeneration.h"

#define CIO_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define CIO_SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define SizeScale ((CIO_SCREEN_HEIGHT > 667) ? CIO_SCREEN_HEIGHT/667 : 1)
#define SizeWithScale ((CIO_SCREEN_WIDTH > 375) ? CIO_SCREEN_WIDTH/375 : 1)

@interface ViewController ()

@property(nonatomic,strong) UIView *backView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor brownColor];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 375, 576)];
    self.backView.backgroundColor = [UIColor redColor];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 576)];
    
    __weak typeof(self) weakSelf = self;
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://images.ciotimes.com/register_sharepic.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
 
        if (error == nil) {
            
            NSLog(@"成功加载图片");
            NSString *cachesPath= [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/sign.png"];
            
            [JKImageGeneration clipScreenWithPath:cachesPath type:@"png" UIView:weakSelf.backView withSize:CGSizeMake(1125,1728)];

            NSLog(@"线程1===%@",[NSThread currentThread]);
            
            [weakSelf showImage];
            
        }else{
            
            NSLog(@"图片加载失败");
        }
    
    }];
    
    [self.backView addSubview:imageView];
    
}

#pragma mark 从沙盒取出剪切的图片展示
-(void)showImage{
    
    NSLog(@"根目录==%@",NSHomeDirectory());
    
    NSLog(@"线程2===%@",[NSThread currentThread]);

    
    NSString *cachesPath2 = [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Caches/sign.png"];
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(64, 115,CIO_SCREEN_WIDTH-64*2,1.54*(CIO_SCREEN_WIDTH-64*2))];
    imageView2.image = [UIImage imageWithContentsOfFile:cachesPath2];
    [self.view addSubview:imageView2];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
