//
//  DiscoveryViewController.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 06/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoveryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
