//
//  SortTypeController.h
//  ReadBooks
//
//  Created by hebiao on 15/10/20.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SortTypeDelegate <NSObject>

-(void)sortTypeDidSelectAction:(int)type;


@end

@interface SortTypeController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    
    UITableView *table;
    
}


@property int sortType;

@property (assign,nonatomic) id<SortTypeDelegate>delegate;


@end
