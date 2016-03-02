//
//  CellDetailController.m
//  ReadBooks
//
//  Created by hebiao on 15/10/19.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "CellDetailController.h"
#import "JSON.h"
#import "ContentDetailController.h"


#define APPW ([UIScreen mainScreen].bounds.size.width)
#define APPH ([UIScreen mainScreen].bounds.size.height)

@interface CellDetailController ()

@end

@implementation CellDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    self.title=self.d[@"bookname"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changec:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
 
    NSString *path=[NSString stringWithFormat:@"novel_zip/novel_content/book_%@/chapters.txt",self.d[@"id"]];
    
   
    NSString *str=[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:path];
    NSString *txtString=[NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
    

    
    
    
    
   
    
    
 
    arrList=[[NSArray alloc] initWithArray:[txtString JSONValue][@"chapters"]];
    
    
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPW, APPH) style:UITableViewStyleGrouped];
    //    table.frame=self.view.frame;
    table.dataSource=self;
    table.delegate=self;
    [self.view addSubview:table];
    
    
    
 
    
    
    
}


-(void)changec:(id)sender{
    
    //    NSLog(@"%f",APPH);
    table.frame=CGRectMake(0, 0, APPW, APPH);
    [table reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrList count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_cell"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *d=arrList[indexPath.row];
    
    
    
    
    UILabel *name=[[UILabel alloc] init];
    name.frame=CGRectMake(10, 10, APPW-20, 30);
    name.font=[UIFont systemFontOfSize:16];
    name.text=d[@"title"];
    [cell addSubview:name];
    
    
    
    
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ContentDetailController *cdc=[[ContentDetailController alloc] init];
    cdc.d=arrList[indexPath.row];
    cdc.superId=[NSString stringWithFormat:@"%@",self.d[@"id"]];
    [self.navigationController pushViewController:cdc animated:YES];
    
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
