//
//  ViewController.m
//  TableViewDemo
//
//  Created by Nidhi on 10/27/17.
//  Copyright © 2017 CreoleStudios. All rights reserved.
//

#import "ViewController.h"
#import "DisplayTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int count;
    NSMutableArray *arrData;
    NSMutableArray *arrSelectedSectionIndex;
    BOOL isMultipleExpansionAllowed;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    arrData = [[NSMutableArray alloc] init];
    arrSelectedSectionIndex = [[NSMutableArray alloc] init];
    isMultipleExpansionAllowed = true;
    count = 20;
    
    if (!isMultipleExpansionAllowed)
    {
        NSNumber *value;
        value = [NSNumber numberWithInteger: count+2];;
        [arrSelectedSectionIndex addObject:value];
    }
    
    NSMutableArray *arrMainData = [[NSMutableArray alloc]init];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSMutableDictionary *dict2 =[[NSMutableDictionary alloc]init];
    dict2[@"name"] = @"Nidhi";
    [arr addObject:dict2];
    
    dict2 =[[NSMutableDictionary alloc]init];
    dict2[@"name"] = @"Dhara";
    [arr addObject:dict2];
    
    NSMutableArray *arr2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *dict22 =[[NSMutableDictionary alloc]init];
    dict22[@"name"] = @"Fenali";
    [arr2 addObject:dict22];
    
    dict22 =[[NSMutableDictionary alloc]init];
    dict22[@"name"] = @"Nirali";
    [arr2 addObject:dict22];
    
    NSMutableArray *arr1 = [[NSMutableArray alloc]init];
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
    dict[@"Title"] = @"Patel";
    dict[@"Data"] = arr;
    [arr1 addObject:dict];
    
    dict =[[NSMutableDictionary alloc]init];
    dict[@"Title"] = @"Jain";
    dict[@"Data"] = arr2;
    [arr1 addObject:dict];
    
    NSMutableDictionary *dict1 =[[NSMutableDictionary alloc]init];
    dict1[@"MainData"] = arr1;
    [arrMainData addObject:dict1];
    NSLog(@"%@", arrMainData);
    arrData = [[arrMainData objectAtIndex:0]valueForKey:@"MainData"];
    NSLog(@"%lu", (unsigned long)[[arrData valueForKey:@"MainData"] count]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrData count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[arrData objectAtIndex:section] valueForKey:@"Data"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewSection = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    viewSection.backgroundColor = [UIColor redColor];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 300, 30)];
    lblTitle.text = [[arrData objectAtIndex:section] valueForKey:@"Title"];
    [viewSection addSubview:lblTitle];
    
    UIButton *btnCheck = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 5, 30, 30)];
    btnCheck.tag = section;
    [btnCheck setImage:[UIImage imageNamed:@"ck_unsel"] forState:UIControlStateNormal];
    [btnCheck addTarget:self
                 action:@selector(myAction:)
       forControlEvents:UIControlEventTouchUpInside];
    [viewSection addSubview:btnCheck];
    return viewSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DisplayTableViewCell *cell = (DisplayTableViewCell *)[self.tblView dequeueReusableCellWithIdentifier:@"DisplayTableViewCell" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[DisplayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DisplayTableViewCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; // style set
    cell.lblName.text = [[[[arrData valueForKey:@"Data"]objectAtIndex:indexPath.section] valueForKey:@"name"] objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)btnCheckClick:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblView];
    NSIndexPath *indexPath = [self.tblView indexPathForRowAtPoint:buttonPosition];
    NSLog(@"%@",[[[arrData valueForKey:@"Data"]objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
}

-(void)myAction:(id)sender
{
    NSLog(@"%@",[arrData objectAtIndex:[sender tag]]);
}
@end
