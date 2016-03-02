//
//  SortTypeController.m
//  ReadBooks
//
//  Created by hebiao on 15/10/20.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "SortTypeController.h"

#define APPW ([UIScreen mainScreen].bounds.size.width)
#define APPH ([UIScreen mainScreen].bounds.size.height)


@interface SortTypeController ()

@end

@implementation SortTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"分类";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changecs:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPW, APPH) style:UITableViewStyleGrouped];
    //    table.frame=self.view.frame;
    table.dataSource=self;
    table.delegate=self;
    [self.view addSubview:table];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_cell"];
    
    
    
//
    
    if (self.sortType-1==indexPath.row) {
       cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    
    
    
    
    UILabel *name=[[UILabel alloc] init];
    name.frame=CGRectMake(10, 10, APPW-20, 30);
    name.font=[UIFont systemFontOfSize:16];
    if (indexPath.row==0) {
        name.text=@"按作者分类";
    }else if (indexPath.row==1){
        name.text=@"按书名分类";
    }else if (indexPath.row==2){
        name.text=@"按国家分类";
    }
    
    [cell addSubview:name];
    
    
    
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate sortTypeDidSelectAction:indexPath.row+1];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



-(void)changecs:(id)sender{
    
    //    NSLog(@"%f",APPH);
    table.frame=CGRectMake(0, 0, APPW, APPH);
    [table reloadData];
    
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
