//
//  CLNavController.m
//  CLWinXin
//
//  Created by nil on 16/7/31.
//  Copyright © 2016年 Lee_Cen. All rights reserved.
//

#import "CLNavController.h"
#import "UINavigationBar+Awesome.h"

@interface CLNavController ()

@end

@implementation CLNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //微信 navBar颜色不是黑色，具体颜色再看
    [self.navigationBar lt_setBackgroundColor:[UIColor blackColor]];
    //修改标题颜色
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    //修改左右 UIBarButtoIitm 颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
