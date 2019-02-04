//
//  PairsViewController.m
//  Currate
//
//  Created by Eugene Vegner on 2/4/19.
//  Copyright © 2019 Eugene Vegner. All rights reserved.
//

#import "PairsViewController.h"
#import "PairTableViewCell.h"
#import "PairListFooterView.h"
#import "InfoViewController.h"
#import "Service.h"
#import "Pair.h"
#import "Alerts.h"

@interface PairsViewController () <UITableViewDataSource, UITableViewDelegate, PairTableViewCellCheckedDelegate, PairListFooterViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<Pair *> *source;
@property (nonatomic, strong) NSMutableArray<NSString *> *selectedKeys;
@property (nonatomic, strong) PairListFooterView *footerView;


@end

@implementation PairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Pairs";
    self.selectedKeys = [NSMutableArray array];
    
    CGFloat footerHeight = 80;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style: UITableViewStylePlain];
    [self.tableView registerClass:[PairTableViewCell class] forCellReuseIdentifier:kPairListCellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - footerHeight)];
    [self.view addSubview:_tableView];
    
    
    //[self fetchData];
    self.footerView = [[PairListFooterView alloc] init];
    self.footerView.backgroundColor = [UIColor greenColor];
    [self.footerView setFrame:CGRectMake(0, self.view.frame.size.height - footerHeight, self.view.frame.size.width, footerHeight)];
    [self.footerView setDelegate:self];
    [self.view addSubview:_footerView];
    
    [self fetchData];
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
                               dequeueReusableCellWithIdentifier:kPairListCellIdentifier
                               forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[PairTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                        reuseIdentifier:kPairListCellIdentifier];
    }
    cell.indexPath = indexPath;
    
    Pair *pair = [self.source objectAtIndex:indexPath.row];
    cell.titleLabel.text = pair.title;
    [cell.checkBox setOn: [self.selectedKeys containsObject:pair.title]];
    cell.checkBoxDelegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

// MARK: - PairListFooterViewDelegate

- (void)didSwitchCell:(PairTableViewCell *)cell selected:(BOOL)selected atIndexPath:(NSIndexPath *)indexPath {
    Pair *pair = [self.source objectAtIndex:indexPath.row];
    if (!selected) {
        if ([self.selectedKeys containsObject:pair.title]) {
            [self.selectedKeys removeObject:pair.title];
        }
    } else {
        if (![self.selectedKeys containsObject:pair.title]) {
            [self.selectedKeys  addObject:pair.title];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    });
}

// MARK: - PairListFooterViewDelegate

- (void)didPressInfo {
    if (self.selectedKeys.count == 0) {
        [Alerts showErrorMessage:@"Please select pairs"];
        return;
    }
    
    [self showInfo];
}

// MARK: - Server

- (void)fetchData {
    Service *service = [[Service alloc] init];
    [service getCurrencyList:^(NSArray<Pair *> * _Nullable list) {
        self.source = list;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.source) {
                [Alerts showErrorMessage:@"df"];
            } else {
                [self.tableView reloadData];
            }
        });
        
    }];
}


// MARK:- Navigation

- (void)showInfo {
    InfoViewController *info = [[InfoViewController alloc] init];
    info.keys = self.selectedKeys;
    [self.navigationController pushViewController:info animated:YES];
}


@end
