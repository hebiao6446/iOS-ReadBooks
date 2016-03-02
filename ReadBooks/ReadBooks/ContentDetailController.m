//
//  ContentDetailController.m
//  ReadBooks
//
//  Created by hebiao on 15/10/20.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "ContentDetailController.h"
#import "JSON.h"

#define APPW ([UIScreen mainScreen].bounds.size.width)
#define APPH ([UIScreen mainScreen].bounds.size.height)

@interface ContentDetailController ()

@end

@implementation ContentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changecc:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    
    NSString *path=[NSString stringWithFormat:@"novel_zip/novel_content/book_%@/%@.txt",self.superId, self.d[@"id"]];
    
    
    NSString *str=[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:path];
    NSString *txtString=[NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary *dc=[txtString JSONValue];
    
     context=dc[@"content"];
    self.title=dc[@"title"];
    
    webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, APPW, APPH)];
    webView.backgroundColor=[UIColor whiteColor];
    [webView loadHTMLString:context baseURL:nil];
//    webView.scrollView.showsVerticalScrollIndicator=NO;
    [webView setBackgroundColor:[UIColor clearColor]];
    [webView setOpaque:NO];
    for (UIView *subView in [webView subviews]) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView *shadowView in [subView subviews]) {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    shadowView.hidden = YES;
                }
            }
        }
    }
    [self.view addSubview:webView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    if (context==nil) {
         [[[UIAlertView alloc] initWithTitle:@"无内容" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)changecc:(id)sender{
    
    //    NSLog(@"%f",APPH);
    webView.frame=CGRectMake(0, 0, APPW, APPH);
    [webView loadHTMLString:context baseURL:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
