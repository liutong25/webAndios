//
//  ViewController.m
//  webAndios
//
//  Created by 刘通 on 2017/8/29.
//  Copyright © 2017年 tong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myweb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //通过本地html文件加载网页
    [self.myweb loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"]]];
    [self.myweb stringByEvaluatingJavaScriptFromString:@""];
    self.myweb.delegate = self;
    
    //有改变嘛？
    NSLog(@"123321");
    
}

- (void)call{
    //拨打电话
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://10086"]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"] options:@{} completionHandler:^(BOOL success) {
        
    }];
}

//是否允许加载从webview获得的请求
/*
 *该方法可以实现js调用OC
 *js和OC交互的第三框架可以使用：WebViewJavaScriptBridge
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //获得html点击的链接
    NSString *url = request.URL.absoluteString;
    //设置协议头
    NSString *scheme = @"zc://";
    //判断获得的链接前面是否包含设置头
    if([url hasPrefix:scheme]){
        
        //切割字符串
        NSString *methodName = [url substringFromIndex:scheme.length];
        //调用打电话的方法
        [self performSelector:NSSelectorFromString(methodName) withObject:nil];
        
        return NO;
        
    }else{
        
        return YES;
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
