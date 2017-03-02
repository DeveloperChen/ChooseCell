//
//  ViewController.m
//  ChooseCell
//
//  Created by 陈永辉 on 17/3/2.
//  Copyright © 2017年 Chenyonghui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *dataDic;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *expendArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"多选";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"role" ofType:@"plist"];
    NSMutableArray *rootArray = [NSMutableArray arrayWithContentsOfFile:path];
    for (int i = 0; i < rootArray.count; i ++) {
        NSArray *list = [rootArray[i] objectForKey:@"list"];
        [self.dataDic setObject:list forKey:[rootArray[i] objectForKey:@"name"]];
    }
    self.dataArray = [self.dataDic allKeys];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.tableView setTableFooterView:view];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    return _dataDic;
}

- (NSMutableArray *)expendArray {
    if (!_expendArray) {
        _expendArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _expendArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = self.dataArray[section];
    NSArray *array = self.dataDic[key];
    if ([self.expendArray containsObject:key]) {
        return array.count;
    }else {
        return 0.5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIControl *view = [[UIControl alloc] init];
    [view addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
    view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 2, [UIScreen mainScreen].bounds.size.width - 20, 40);
    label.textColor = [UIColor blackColor];
    label.text = self.dataArray[section];
    [view addSubview:label];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = self.dataArray[indexPath.section];
    NSArray *array = self.dataDic[key];
    NSString *name = array[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = name;
    return cell;
}

- (void)showDetails:(UIControl *)sender {
    UILabel  *label = sender.subviews[0];
    NSString *key = label.text;
    NSInteger index = [self.dataArray indexOfObject:key];
    if ([self.expendArray containsObject:key]) {
        [self.expendArray removeObject:key];
    }else {
        [self.expendArray addObject:key];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
