//
//  ProcessingRecognitionTableViewController.m
//  FaceRecognition
//
//  Created by Remi Robert on 12/06/16.
//  Copyright © 2016 Remi Robert. All rights reserved.
//

#import "ProcessingRecognitionTableViewController.h"
#import "FaceCollectionViewCell.h"
#import "FaceRecognition.h"
#import "FaceContact.h"
#import "SelectContactViewController.h"

@interface ProcessingRecognitionTableViewController () <UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionviewFrames;
@property (weak, nonatomic) IBOutlet UIImageView *imageviewResult;
@end

@implementation ProcessingRecognitionTableViewController

- (IBAction)cancelRecognition:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;

    [self.collectionviewFrames registerNib:[UINib nibWithNibName:@"FaceCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionviewFrames.delegate = self;
    self.collectionviewFrames.dataSource = self;

    RLMResults<FaceContact *> *contactsFace = [FaceContact allObjects];
    NSLog(@"objects fund ; %@", contactsFace);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"selectContactSegue"]) {
        ((SelectContactViewController *)segue.destinationViewController).face = self.face;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        [self performSegueWithIdentifier:@"selectContactSegue" sender:nil];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.face.faces.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FaceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell configureWithImage:[self.face.faces objectAtIndex:indexPath.row]];
    return cell;
}

@end
