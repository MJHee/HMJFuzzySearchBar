//
//  ViewController.m
//  HMJFuzzySearchBar
//
//  Created by MJHee on 16/9/5.
//  Copyright © 2016年 MJHee. All rights reserved.
//

#import "ViewController.h"
#import "HMJSchool.h"
#import "HMJSchoolTool.h"

@interface ViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

//添加一个数组，用来保存person
@property (nonatomic, strong) NSArray *schools;
@property (nonatomic, strong) UISearchBar *search;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL haveDeleteTable;

@end

static NSString *searchCellId = @"searchCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleteTable)];

    [self setTable];

    self.navigationItem.titleView = self.search;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.haveDeleteTable) {

        [self setTable];
    }
}

- (void)setTable {

    [self addSchool];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:searchCellId];
}

#pragma mark - delete table

- (void)deleteTable {
    self.haveDeleteTable = YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"self.schools.count = %ld", self.schools.count);
    return self.schools.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchCellId forIndexPath:indexPath];

    HMJSchool *school = self.schools[indexPath.row];

    cell.textLabel.text = school.name;

    return cell;
}

- (void)addSchool {
    //初始化一些假数据
    NSArray *names = @[@"1", @"1", @"1", @"2", @"3", @"11", @"22", @"33", @"111", @"222", @"333", @"1111", @"2222"];
    for (int i = 0; i < names.count; i++) {
        HMJSchool *s = [[HMJSchool alloc] init];
        s.schoolId = [NSString stringWithFormat:@"%d", (i + 1)];
        s.name     = names[i];
        [HMJSchoolTool save:s];
    }
}

#pragma mark - UITableViewDelegate



#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.schools = [HMJSchoolTool queryWithCondition:searchText];
    //刷新表格
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

#pragma mark - 懒加载

- (UISearchBar *)search {
    if (_search == nil) {
        _search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        _search.delegate = self;
//        _search.showsCancelButton = YES;
        _search.keyboardType = UIKeyboardTypeDefault;
        _search.placeholder  = @"大学名称/简称";
    }
    return _search;
}

- (NSArray *)schools {
    if (!_schools) {
        _schools = [HMJSchoolTool query];
    }
    return _schools;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
