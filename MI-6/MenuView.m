//
//  MenuView.m
//  MI-6
//
//  Created by Влад Мазур on 05.10.13.
//  Copyright (c) 2013 Vlad Mazur. All rights reserved.
//

#import "MenuView.h"
#import <QuartzCore/QuartzCore.h>

@interface MenuView ()

@end

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
        
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
    return self;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.box count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
#define ID @[@"MenuItem", @"ExitItem"]
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID[indexPath.section]];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:ID[indexPath.section]];
    }
        cell.textLabel.text = [self.box subjectAtIndex:indexPath.row].name; //@"smth";
    //    cell.textLabel.font = [cell.textLabel.font fontWithSize:8];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSLog(@"%d", indexPath.row);
    
    Subject * subj = [self.box subjectAtIndex:indexPath.row];
    [self.father loadSubject:subj];
}

-(NSUInteger) count
{
    return [self.box count];
}

@end
