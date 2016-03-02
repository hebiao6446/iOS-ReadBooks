//
//  CellDetailController.h
//  ReadBooks
//
//  Created by hebiao on 15/10/19.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellDetailController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *arrList;
    UITableView *table;
    
}

@property (retain) NSDictionary *d;


@end
