//
//  ViewController.m
//  TableViewDemo
//
//  Created by Nidhi on 10/27/17.
//  Copyright © 2017 CreoleStudios. All rights reserved.
//

#import "ViewController.h"
#import "DisplayTableViewCell.h"
#import "HeaderTableViewCell.h"

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
    dict2[@"isCheck"] = @"0";
    [arr addObject:dict2];
    
    dict2 =[[NSMutableDictionary alloc]init];
    dict2[@"name"] = @"Dhara";
    dict2[@"isCheck"] = @"0";
    [arr addObject:dict2];
    
    NSMutableArray *arr2 = [[NSMutableArray alloc]init];
    NSMutableDictionary *dict22 =[[NSMutableDictionary alloc]init];
    dict22[@"name"] = @"Fenali";
    dict22[@"isCheck"] = @"0";
    [arr2 addObject:dict22];
    
    dict22 =[[NSMutableDictionary alloc]init];
    dict22[@"name"] = @"Nirali";
    dict22[@"isCheck"] = @"0";
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
    return 44;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderTableViewCell *cell = (HeaderTableViewCell *)[self.tblView dequeueReusableCellWithIdentifier:@"HeaderTableViewCell"];
    if (cell == nil)
    {
        cell = [[HeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeaderTableViewCell"];
    }
    cell.contentView.backgroundColor = [UIColor redColor];
    cell.btnHeaderCheck.tag = section;
    cell.lblHeaderText.text = [[arrData objectAtIndex:section] valueForKey:@"Title"];
    
//    if (cell.btnHeaderCheck.isSelected)
        [cell.btnHeaderCheck setSelected:NO];
//    else
//        [cell.btnHeaderCheck setSelected:YES];
    return cell.contentView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DisplayTableViewCell *cell = (DisplayTableViewCell *)[self.tblView dequeueReusableCellWithIdentifier:@"DisplayTableViewCell" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[DisplayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DisplayTableViewCell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; // style set
    cell.lblName.text = [[[[arrData valueForKey:@"Data"]objectAtIndex:indexPath.section] valueForKey:@"name"] objectAtIndex:indexPath.row];
    NSString *str = [[[[arrData valueForKey:@"Data"]objectAtIndex:indexPath.section] valueForKey:@"isCheck"] objectAtIndex:indexPath.row];
    if ([str integerValue] == 1)
        [cell.btnCheck setSelected:YES];
    else
        [cell.btnCheck setSelected:NO];
    return cell;
}

- (IBAction)btnCheckClick:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblView];
    NSIndexPath *indexPath = [self.tblView indexPathForRowAtPoint:buttonPosition];
    NSLog(@"%@",[[[arrData valueForKey:@"Data"]objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
    NSMutableDictionary *dict = [[[arrData valueForKey:@"Data"]objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([dict[@"isCheck"] integerValue] == 1)
        dict[@"isCheck"] =@"0";
    else
        dict[@"isCheck"] =@"1";
    [self.tblView reloadData ];
}

- (IBAction)btnHeaderCheckClick:(id)sender {
    
    if ([sender isSelected])
    {
        [sender setSelected:NO];
    }
    else
    {
        [sender setSelected:YES];
    }
    
    NSLog(@"%@",[arrData objectAtIndex:[sender tag]]);
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    arr = [[arrData valueForKey:@"Data"]objectAtIndex:[sender tag]];

    for (NSMutableDictionary *dict in arr)
    {
        if ([sender isSelected])
        {
            dict[@"isCheck"] =@"1";
        }
        else
        {
            dict[@"isCheck"] =@"0";
        }
    }

    [self.tblView reloadData ];
}
@end

//    UIView *viewSection = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
//    viewSection.backgroundColor = [UIColor redColor];
//
//    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 300, 30)];
//    lblTitle.text = [[arrData objectAtIndex:section] valueForKey:@"Title"];
//    [viewSection addSubview:lblTitle];
//
//    UIButton *btnCheck = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 5, 30, 30)];
//    btnCheck.tag = section;
//    [btnCheck setImage:[UIImage imageNamed:@"ck_unsel"] forState:UIControlStateNormal];
//    [btnCheck addTarget:self
//                 action:@selector(myAction:)
//       forControlEvents:UIControlEventTouchUpInside];
//    [viewSection addSubview:btnCheck];
//    return viewSection;


//-(void)myAction:(id)sender
//{
//    NSLog(@"%@",[arrData objectAtIndex:[sender tag]]);
//    NSMutableArray *arr = [[NSMutableArray alloc]init];
//    arr = [[arrData valueForKey:@"Data"]objectAtIndex:[sender tag]];
//
//    for (NSMutableDictionary *dict in arr)
//    {
//        dict[@"isCheck"] =@"1";
//    }
//
//    [self.tblView reloadData ];
//}

