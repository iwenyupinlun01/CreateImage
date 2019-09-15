//
//  JKImageGeneration.h
//  JKCreateImage
//
//  Created by 王冲 on 2018/9/7.
//  Copyright © 2018年 JK科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JKImageGeneration : NSObject

#pragma mark 把一个UIView生成PNG或者JPG格式的图片,保存在指定路径
+(void)clipScreenWithPath:(NSString *)path type:(NSString *)type UIView:(UIView *)view withSize:(CGSize)pitureSize;
#pragma mark  修改Image图片的大小(暂时没有用)
+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
@end
