//
//  FavoriteViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "FavoriteViewController.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary *titleTextAttributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor whiteColor], UITextAttributeTextColor,
                                             [UIColor whiteColor], UITextAttributeTextShadowColor,
                                             [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                             [UIFont fontWithName:@"BrandonGrotesque-Bold" size:23.0], UITextAttributeFont,
                                             nil];
    [self.navigationController.navigationBar setTitleTextAttributes: titleTextAttributesDict];
    
	// Do any additional setup after loading the view.
    _favouriteData = [[Favourites sharedManager] getFavourites];
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.topItem.title = @"Favorite";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_favouriteData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[_favouriteData objectAtIndex:indexPath.row] getListName];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    _favouriteData = nil;
}

@end
