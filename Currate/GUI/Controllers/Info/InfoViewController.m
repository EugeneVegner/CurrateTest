//
//  InfoViewController.m
//  Currate
//
//  Created by Eugene Vegner on 2/4/19.
//  Copyright © 2019 Eugene Vegner. All rights reserved.
//

#import "InfoViewController.h"
#import "PairTableViewCell.h"
#import "Pair.h"
#import "Service.h"
#import "Alerts.h"

@interface InfoViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<Pair *> *source;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style: UITableViewStylePlain];
    [self.tableView registerClass:[PairTableViewCell class] forCellReuseIdentifier:kPairInfoCellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setFrame:self.view.frame];
    [self.view addSubview:_tableView];
    
    [self fetchInfo];
}

// MARK: - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.source.count ?: 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PairTableViewCell *cell = [tableView
                               dequeueReusableCellWithIdentifier:kPairInfoCellIdentifier
                               forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PairTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                        reuseIdentifier:kPairInfoCellIdentifier];
    }
    
    Pair *pair = [self.source objectAtIndex:indexPath.row];
    cell.titleLabel.text = pair.title;
    cell.infoLabel.text = [NSString stringWithFormat:@"%@",pair.value];//pair.value.stringValue;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}


- (void)fetchInfo {
    Service *service = [[Service alloc] init];
    [service getRatesByPairs:self.keys success:^(NSArray<Pair *> * _Nullable list) {
        self.source = list;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!list) {
                [Alerts showErrorMessage:@"Error fetch info"];
            } else {
                [self.tableView reloadData];
            }
        });
    }];
}



@end
