//
//  JKImageGeneration.m
//  JKCreateImage
//
//  Created by 王冲 on 2018/9/7.
//  Copyright © 2018年 JK科技有限公司. All rights reserved.
//

#import "JKImageGeneration.h"

@implementation JKImageGeneration

/**
 *  把一个UIView生成PNG或者JPG格式的图片,保存在指定路径
 *  @param path   图片要保存到的路径
 *  @param type   图片的格式png或者jpg
 *  @param view 要转成图片的UIView
 */
+(void)clipScreenWithPath:(NSString *)path type:(NSString *)type UIView:(UIView *)view withSize:(CGSize)pitureSize
{
    //1.开启一个和传进来的View大小一样的位图上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,NO,0);
    //2.把控制器的View绘制到上下文当中
    //想把UIView上面的东西绘制到上下文当中,必须得使用渲染的方式
    //renderInContext:就是渲染的方式
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:ctx ];
    
    //3从上下文当中生成一张图片
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsBeginImageContext(CGSizeMake(pitureSize.width, pitureSize.height));
    
    [newImage drawInRect:CGRectMake(0, 0, pitureSize.width, pitureSize.height)];
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭上下文
    UIGraphicsEndImageContext();

    //5.把生成的图片写入到桌面(以文件的方式进行传输:二进制流NSData,即把图片转为二进制流)
    NSData *data;
    
    if ([type isEqualToString:@"png"]) {
        
        //生成PNG格式的图片
        data = UIImagePNGRepresentation(reSizeImage);
        
    }else if ([type isEqualToString:@"jpg"]){
        
        //5.1把图片转为二进制流(第一个参数是图片,第2个参数是图片压缩质量:1是最原始的质量)
        data = UIImageJPEGRepresentation(reSizeImage,1);
    }
    
    [data writeToFile:path atomically:YES];
    
}


/**
 修改Image图片的大小

 @param image UIImage对象
 @param reSize 传进来的是像素的大小
 @return 修改后的UIImage对象
 */
+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}


@end
