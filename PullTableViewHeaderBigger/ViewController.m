//
//  ViewController.m
//  PullTableViewHeaderBigger
//
//  Created by jerryliao on 2018/4/21.
//  Copyright © 2018年 jerryliao. All rights reserved.
//

#import "ViewController.h"
#import "JELNavigationBar.h"

static CGFloat const ratio = 0.8;
static CGFloat const headerHeight = 160;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) JELNavigationBar *navigationBar;
@property (strong, nonatomic) UIImageView *backImageView;
@property (assign, nonatomic) CGRect originalFrame;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.f, self.view.frame.size.width, ratio * self.view.frame.size.width)];
    self.backImageView.image = [UIImage imageNamed:@"backImage"];
    [self.view insertSubview:self.backImageView atIndex:0];
    
    self.originalFrame = self.backImageView.frame;
    
    self.navigationBar = [[JELNavigationBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 64)];
    self.navigationBar.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.navigationBar];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, headerHeight)];
    headerView.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([UITableViewCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"我只是一列";
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset < headerHeight) {
        CGFloat colorAlpha = yOffset / headerHeight;
        self.navigationBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:colorAlpha];
        self.navigationBar.titleColor = [UIColor whiteColor];
    } else {
        self.navigationBar.backgroundColor = [UIColor whiteColor];
        self.navigationBar.titleColor = [UIColor greenColor];
    }
    
    if (yOffset > 0) {
        self.backImageView.frame = ({
            CGRect frame = self.originalFrame;
            frame.origin.y = self.originalFrame.origin.y - yOffset;
            frame;
        });
    }
    else {
        self.backImageView.frame = ({
            CGRect frame = self.originalFrame;
            frame.size.height = self.originalFrame.size.height - yOffset;
            frame.size.width = frame.size.height / ratio;
            frame.origin.x = self.originalFrame.origin.x - (frame.size.width - self.originalFrame.size.width) / 2;
            frame;
        });
    }
}

@end
