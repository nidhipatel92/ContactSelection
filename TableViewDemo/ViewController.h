//
//  ViewController.h
//  TableViewDemo
//
//  Created by Nidhi on 10/27/17.
//  Copyright © 2017 CreoleStudios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)btnCheckClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tblView;
- (IBAction)btnHeaderCheckClick:(id)sender;

@end

