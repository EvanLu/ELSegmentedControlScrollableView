## ELSegmentedControlScrollableView
Easy way to use segmentedcontrol ineract with scrollview

## Installation
```Objective-C
#import "ELSegmentedControl.h"
```

## Usage - controls four sub views
```Objective-C

ELSegmentedControl *segmentedControlScrollableView;
segmentedControlScrollableView = [[ELSegmentedControl alloc] initWithItemsContentViews:[NSArray arrayWithObjects:@"view0", @"view1", @"view2", @"view3", nil] delegateParentView:self.view contentViews:[NSMutableArray arrayWithObjects:view0, view1, view2, view3, nil]];
[segmentedControlScrollableView setBottomStickColor:[UIColor blackColor]];
```

Or see the "ViewController.m" for more detail

## Screenshot
<img src="https://cloud.githubusercontent.com/assets/1875330/11113364/44bef170-8957-11e5-97ef-99c6df6037ef.gif" width="367" height="663" />

## Licence
ELSegmentedControlScrollableView is available under the MIT license. See the LICENSE file for more info.
