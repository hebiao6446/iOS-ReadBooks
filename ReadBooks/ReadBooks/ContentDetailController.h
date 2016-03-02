//
//  ContentDetailController.h
//  ReadBooks
//
//  Created by hebiao on 15/10/20.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentDetailController : UIViewController<UIAlertViewDelegate>{
    
    UIWebView *webView;
    NSString *context;
    
}

@property (retain) NSDictionary *d;
@property (retain) NSString *superId;

@end
