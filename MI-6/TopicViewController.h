//
//  TopicViewController.h
//  MI-6
//
//  Created by Влад Мазур on 29.09.13.
//  Copyright (c) 2013 Vlad Mazur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"
#import "SubjectBox.h"

@interface TopicViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) Subject * subject;
@property (strong, nonatomic) SubjectBox * box;

-(void)cellClicked:(NSIndexPath *)indexPath;

-(void)loadSubject:(Subject *)subject;

@end
