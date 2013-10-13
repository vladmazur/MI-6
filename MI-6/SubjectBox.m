//
//  SubjectBox.m
//  MI-6
//
//  Created by Влад Мазур on 29.09.13.
//  Copyright (c) 2013 Vlad Mazur. All rights reserved.
//

#import "SubjectBox.h"

@interface SubjectBox()

@end

@implementation SubjectBox

@synthesize subjects = _subjects;

-(NSMutableArray *) subjects
{
    if (!_subjects) _subjects = [NSMutableArray array];
    return _subjects;
}

-(Subject *) subjectAtIndex:(NSUInteger)index
{
    return [_subjects objectAtIndex:index];
}

-(void) addSubject:(Subject *)subject
{
    [self.subjects addObject:subject];
}


-(NSUInteger) count
{
    return [_subjects count];
}

-(SubjectBox *)SubjectBoxWithoutOneSubject:(Subject *)subject
{
    SubjectBox * newBox = [self copy];
    [newBox.subjects removeObject:subject];
    return newBox;
}

-(id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] allocWithZone:zone] init];
    [copy setSubjects:[self.subjects mutableCopy]];
    return copy;
}

@end
