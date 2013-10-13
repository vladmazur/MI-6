//
//  Subject.m
//  MI-6
//
//  Created by Влад Мазур on 29.09.13.
//  Copyright (c) 2013 Vlad Mazur. All rights reserved.
//

#import "Subject.h"

@implementation Subject

-(Subject *)initWithName:(NSString *)name AndFile:(NSString *)file
{
    self = [super init];
    if (self) {
        _name = name;
        _file = file;
//        [self loadFile];
    }
    return self;
}

-(void) loadFile
{
    if (_file)
    {
        NSLog(@"file load");
    }
}


@end
