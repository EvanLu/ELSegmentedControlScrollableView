//
//  ViewController.m
//  ELSegmentedControl
//
//  Created by LuEvan on 2015/11/4.
//  Copyright © 2015年 EvanLu. All rights reserved.
//

#import "ViewController.h"
#import "ELSegmentedControl.h"

@interface ViewController ()
@property ELSegmentedControl *segmentedControlScrollableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [view0 setBackgroundColor:[UIColor blackColor]];
    [view1 setBackgroundColor:[UIColor redColor]];
    [view2 setBackgroundColor:[UIColor grayColor]];
    [view3 setBackgroundColor:[UIColor greenColor]];
    
    _segmentedControlScrollableView = [[ELSegmentedControl alloc] initWithItemsContentViews:[NSArray arrayWithObjects:@"view0", @"view1", @"view2", @"view3", nil] delegateParentView:self.view contentViews:[NSMutableArray arrayWithObjects:view0, view1, view2, view3, nil]];
    [_segmentedControlScrollableView setBottomStickColor:[UIColor blackColor]];
}

-(void)viewDidAppear:(BOOL)animated{

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
