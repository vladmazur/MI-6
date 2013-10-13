//
//  Subject.h
//  MI-6
//
//  Created by Влад Мазур on 29.09.13.
//  Copyright (c) 2013 Vlad Mazur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subject : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *file;

-(Subject *)initWithName:(NSString *)name AndFile:(NSString *)file;
@end
