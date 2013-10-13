//
//  SubjectBox.h
//  MI-6
//
//  Created by Влад Мазур on 29.09.13.
//  Copyright (c) 2013 Vlad Mazur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Subject.h"

@interface SubjectBox : NSObject <NSCopying>

@property (strong, nonatomic) NSMutableArray * subjects;

-(Subject *) subjectAtIndex:(NSUInteger)index;
-(void) addSubject:(Subject *)subject;

-(NSUInteger) count;

-(SubjectBox *)SubjectBoxWithoutOneSubject:(Subject *)subject;

@end
