//
//  ViewController.m
//  NetworkingDemo
//
//  Created by David Mills on 2019-01-24.
//  Copyright © 2019 David Mills. All rights reserved.
//

#import "ViewController.h"
#import "MPTableViewCell.h"

@interface ViewController () <UITableViewDataSource>

@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSArray *representatives;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  self.representatives = @[];
}

- (void)viewDidAppear:(BOOL)animated {
  [self fetchRepresentatives];
}

- (void)fetchRepresentatives {
  NSURL *url = [NSURL URLWithString:@"https://represent.opennorth.ca/representatives/house-of-commons/"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  NSURLSessionTask *task =
      [[NSURLSession sharedSession] dataTaskWithRequest:request
                                      completionHandler:^(NSData * _Nullable data,
                                                          NSURLResponse * _Nullable response,
                                                          NSError * _Nullable error) {
    NSError *jsonError;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:&jsonError];
    NSArray *objects = json[@"objects"];

    NSMutableArray *reps = [NSMutableArray new];
    for (NSDictionary *repDict in objects) {
      Representative *rep = [Representative fromJsonDictionary:repDict];
      [reps addObject:rep];
    }

    self.representatives = reps;

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self.tableView reloadData];
    }];
  }];

  [task resume];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.representatives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mpCell" forIndexPath:indexPath];

  cell.rep = self.representatives[indexPath.row];

  return cell;
}


@end
