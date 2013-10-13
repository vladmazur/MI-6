//
//  MenuView.h
//  MI-6
//
//  Created by Влад Мазур on 05.10.13.
//  Copyright (c) 2013 Vlad Mazur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectBox.h"
#import "TopicViewController.h"

@interface MenuView : UITableView <UITableViewDataSource, UITableViewDelegate>

//@property (nonatomic) NSUInteger height;
@property (strong, nonatomic) SubjectBox * box;

-(NSUInteger) count;

@property (weak, nonatomic) TopicViewController * father;

@end
