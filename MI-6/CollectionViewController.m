//
//  CollectionViewController.m
//  MI-6
//
//  Created by Влад Мазур on 29.09.13.
//  Copyright (c) 2013 Vlad Mazur. All rights reserved.
//

#import "CollectionViewController.h"

#import "SubjectBox.h"
#import "SubjectViewCell.h"
#import "TopicViewController.h"

@interface CollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView * subjectsCollection;
@property (strong, nonatomic) SubjectBox * box;

@end

@implementation CollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _box = [[SubjectBox alloc] init];
    Subject * subj = [[Subject alloc] initWithName:@"2.1.1.1" AndFile:@"2.1.1.1"];
    [_box addSubject:subj];
    subj = [[Subject alloc] initWithName:@"2.1.1.2" AndFile:@"2.1.1.2"];
    [_box addSubject:subj];
    subj = [[Subject alloc] initWithName:@"2.1.1.3 fake" AndFile:@"2.1.1.3"];
    [_box addSubject:subj];
    subj = [[Subject alloc] initWithName:@"2.1.1.4 fake" AndFile:@"2.1.1.4"];
    [_box addSubject:subj];
}

#pragma mark - UICollectionView Datasource

-(NSInteger) collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [_box count];
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubjectCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.name.text = [self.box subjectAtIndex:indexPath.item].name;
    cell.layer.cornerRadius = 4.0;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Subject *subj = [self.box subjectAtIndex:indexPath.item];
    [self performSegueWithIdentifier:@"ShowSubject" sender:subj];
    [self.subjectsCollection deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowSubject"]) {
        TopicViewController * tvc = segue.destinationViewController;
        tvc.subject = sender;
        tvc.box = self.box;
    }
}

#pragma mark - Appearance

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15.0;
}

@end
