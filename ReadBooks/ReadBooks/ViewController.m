//
//  ViewController.m
//  ReadBooks
//
//  Created by hebiao on 15/10/19.
//  Copyright (c) 2015年 Hebiao. All rights reserved.
//

#import "ViewController.h"

#import "JSON.h"

#define APPW ([UIScreen mainScreen].bounds.size.width)
#define APPH ([UIScreen mainScreen].bounds.size.height)



#import "CellDetailController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleDone target:self action:@selector(typeAction:)];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"gropType"]==nil) {
        gropType=GropTypeBook;
        [[NSUserDefaults standardUserDefaults] setInteger:gropType forKey:@"gropType"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
        gropType=[[NSUserDefaults standardUserDefaults] integerForKey:@"gropType"];
    }
    
    
  
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    self.title=@"100部经典文学";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    
  NSString *str=[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"novel_zip/story.txt"];
  NSString *txtString=[NSString stringWithContentsOfFile:str encoding:NSUTF8StringEncoding error:nil];
     NSLog(@"%@",txtString);
    
    arrList=[[NSArray alloc] initWithArray:[txtString JSONValue]];
    
    mutableArray=[[NSMutableArray alloc] init];
    indexArray=[[NSMutableArray alloc] init];
    
    
    
   
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPW, APPH) ];
//    table.frame=self.view.frame;
    table.dataSource=self;
    table.delegate=self;
    [self.view addSubview:table];
    
    
    [self sortArrayAction];
    
    
}


-(void)typeAction:(id)sender{
    SortTypeController *stc=[[SortTypeController alloc] init];
    stc.sortType=gropType;
    stc.delegate=self;
    [self.navigationController pushViewController:stc animated:YES];
    
}
-(void)sortTypeDidSelectAction:(int)type{
    
    gropType=type;
    [[NSUserDefaults standardUserDefaults] setInteger:gropType forKey:@"gropType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self sortArrayAction];
    

}
-(void)sortArrayAction{
    
    [mutableArray removeAllObjects];
    [indexArray removeAllObjects];
    
    
    NSString *key=@"";
    if (gropType==GropTypeAuthor) {
        key=@"authorchar";
    }else if (gropType==GropTypeBook){
        key=@"booknamechar";
    }else if (gropType==GropTypeContry){
        key=@"contry";
    }
    
    if ([arrList count]==0) {
        return;
    }
    
    NSMutableArray *index=[[NSMutableArray alloc] init];
  
    for (NSDictionary *d in arrList) {
        
        if (![index containsObject:d[key]]) {
            [index addObject:d[key]];
        }
        
    }
    [index sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    for (NSString *kStr in index) {
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        for (NSDictionary *d in arrList) {
            if ([d[key] isEqual:kStr]) {
                [arr addObject:d];
            }
        }
        [indexArray addObject:kStr];
        [mutableArray addObject:@{@"title":kStr,@"arr":arr}];
    }
    
    
    [table reloadData];
    
}


-(void)change:(id)sender{
    
//    NSLog(@"%f",APPH);
    table.frame=CGRectMake(0, 0, APPW, APPH);
    [table reloadData];
    
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return indexArray;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [mutableArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [mutableArray[section][@"arr"] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return mutableArray[section][@"title"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_cell"];
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *d=mutableArray[indexPath.section][@"arr"][indexPath.row];
    
    
    UIImageView *img=[[UIImageView alloc] init];
    img.frame=CGRectMake(20, 10, 60, 80);
    img.image=[UIImage imageNamed:[d[@"img"] lastPathComponent]];
    [cell addSubview:img];
    
    UILabel *name=[[UILabel alloc] init];
    name.frame=CGRectMake(100, 10, APPW-20-100, 30);
    name.font=[UIFont systemFontOfSize:16];
    name.text=[NSString stringWithFormat:@"%@(%@)",d[@"bookname"],d[@"author"]];
    [cell addSubview:name];
    
    UILabel *info=[[UILabel alloc] init];
    info.frame=CGRectMake(99, 40, APPW-20-101, 50);
    info.font=[UIFont systemFontOfSize:13];
    info.textColor=[UIColor lightGrayColor];
    info.text=d[@"info"];
    info.numberOfLines=0;
    [cell addSubview:info];
 
 

    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CellDetailController *cdc=[[CellDetailController alloc] init];
    cdc.d=mutableArray[indexPath.section][@"arr"][indexPath.row];
    [self.navigationController pushViewController:cdc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
