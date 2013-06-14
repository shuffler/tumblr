//
//  FavoriteViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "FavoriteViewController.h"
#import "SinglePostViewController.h"

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
    _textfavorite.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:22];
    UIImageView* logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shumblrlogo.png"]];
    logo.frame= CGRectMake(0,0,20,25);
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logo];
	// Do any additional setup after loading the view.
    _favouriteData = [[Favourites sharedManager] getFavourites];
    [[TMAPIClient sharedInstance] likes: nil callback:^(id response, NSError *error) {
        NSArray *tempArray = [response objectForKey:@"liked_posts"];
        NSLog(@"Response: %@" , response);
        for(int i = 0;i<[tempArray count];i++) {
            NSString *type = [[tempArray objectAtIndex:i] objectForKey:@"type"];
            id<Post> object;
            if ([type isEqual:@"video"]) {
                object = [[Video alloc] initWithDictionary: [tempArray objectAtIndex:i]];
            }
            else if([type isEqual:@"audio"]) {
                object = [[Audio alloc] initWithDictionary: [tempArray objectAtIndex:i]];
            } else {
                continue;
            }
            [_favouriteData addObject: object];
            [_tableView reloadData];
        }
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.topItem.title = @"Favorite";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_favouriteData count];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueName = [segue identifier];
    if([segueName isEqualToString: @"favourite_segue"]){
        // Place the post in a new view.
        SinglePostViewController *tmp = [segue destinationViewController];
        NSLog(@"Object: %@", [_favouriteData objectAtIndex: _chosenPost] );
        tmp.post = [_favouriteData objectAtIndex: _chosenPost];
    }
}

-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _chosenPost = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"favourite_segue" sender:self];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor blackColor]];
    cell.textLabel.text = [[_favouriteData objectAtIndex:indexPath.row] getListName];
    NSLog(@"Created new cell with text: %@" , cell.textLabel.text);
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //_favouriteData = nil;
}

- (void)viewDidUnload {
    [self setTextfavorite:nil];
    [super viewDidUnload];
}
@end
