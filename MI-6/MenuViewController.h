//
//  MenuViewController.h
//  MI-6
//
//  Created by Влад Мазур on 05.10.13.
//  Copyright (c) 2013 Vlad Mazur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectBox.h"

@interface MenuViewController : UIViewController

@property (strong, nonatomic) SubjectBox * box;
@property (strong, nonatomic) UITableView * view;

@end
