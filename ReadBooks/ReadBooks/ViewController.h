//
//  ViewController.h
//  ReadBooks
//
//  Created by hebiao on 15/10/19.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortTypeController.h"


typedef enum {
 GropTypeAuthor=1,
 GropTypeBook=2,
 GropTypeContry=3
} GropType;

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SortTypeDelegate>{
    
    NSArray *arrList;
    UITableView *table;
    GropType gropType;
    
    NSMutableArray *mutableArray;
    NSMutableArray *indexArray;
    
    
    
}


@end

