//
//  ELSegmentedControl.m
//  ELSegmentedControl
//
//  Created by LuEvan on 2015/10/4.
//  Copyright © 2015年 EvanLu. All rights reserved.
//

#import "ELSegmentedControl.h"

@interface ELScrollView : UIScrollView <UIScrollViewDelegate>
@end

@interface ELScrollView()
@property CGFloat numberOfPages;
@property NSInteger previousPage;

@end
@implementation ELScrollView

-(id)initWithNumberOfPages:(CGFloat)numberOfPages{
    self = [super init];
    if (self) {
        _numberOfPages = numberOfPages;
        _previousPage = 0;
        [self setPagingEnabled:YES];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self setScrollsToTop:NO];
        [self setDelegate:self];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = scrollView.frame.size.width;
    NSInteger currentPage = round(scrollView.contentOffset.x / width);
    NSDictionary *viewChangeInfo = @{@"CurrentPage": [NSString stringWithFormat:@"%ld", currentPage]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"viewChangedNotification" object:viewChangeInfo userInfo:nil];
    _previousPage = currentPage;
}

@end

@interface ELSegmentedControl()
@property UIView *delegateParentView;
@property ELScrollView *scrollView;

@property UISegmentedControl *segmentedControl;
@property UIView *segmentedControlBottomStick;
@property NSMutableArray *contentViewsContainer;
@property CGFloat eachSegmentWidth;

@end

@implementation ELSegmentedControl

-(id)initWithItems:(NSArray *)items{
    self = [super initWithItems:items];
    if (self) {
        return self;
    }
    else
        return nil;
}

-(id)initWithItemsContentViews:(NSArray *)items delegateParentView:(UIView *)delegateParentView contentViews:(NSMutableArray *)contentViews{
    self = [self initWithItems:items];

    if (self) {
        for (id shouldBeUIView in contentViews) {
            NSAssert([shouldBeUIView isKindOfClass:[UIView class]], @"contentViews need to be UIView or subclass of UIview");
        }
        _contentViewsContainer = contentViews;
        _delegateParentView = delegateParentView;

    }
    else
        return nil;
    [self commonInit];
    return self;
}

-(void)commonInit{
    //init notification center
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewChangedNotification:) name:@"viewChangedNotification" object:nil];
    //init self
    self.frame = CGRectMake(0, 0, _delegateParentView.frame.size.width, SEGMENTED_CONTROL_DEFAULT_HEIGHT);
    [self setSelectedSegmentIndex:0];
    self.tintColor = [UIColor clearColor];
    NSDictionary *normalAttr = @{
                                 NSFontAttributeName: [UIFont systemFontOfSize:16],
                                 NSForegroundColorAttributeName: [UIColor blackColor]
                                 };
    [self setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [self addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    //init bottom line of segmented control
    _eachSegmentWidth = _delegateParentView.frame.size.width / [_contentViewsContainer count];
    _segmentedControlBottomStick = [[UIView alloc] initWithFrame:CGRectMake(5, self.frame.size.height - 6, _eachSegmentWidth - 10, SEGMENTED_CONTROL_BOTTOM_LINE_HEIGHT)];
    _segmentedControlBottomStick.backgroundColor = [UIColor blackColor];
    
    //init scrollview
    _scrollView = [[ELScrollView alloc] initWithNumberOfPages:[_contentViewsContainer count]];
    CGFloat contentTotalWidth = 0.f;
    CGRect parentViewFrame = _delegateParentView.frame;
    for (UIView *thisView in _contentViewsContainer) {
        contentTotalWidth += thisView.frame.size.width;
    }
    _scrollView.frame = CGRectMake(0, SEGMENTED_CONTROL_DEFAULT_HEIGHT, parentViewFrame.size.width, parentViewFrame.size.height);
    [_scrollView setContentSize:CGSizeMake(contentTotalWidth, parentViewFrame.size.height)];
    
    //init origin of content views
    for (int i = 0 ; i < [_contentViewsContainer count] ; i++) {
        UIView *thisView = [_contentViewsContainer objectAtIndex:i];
        thisView.frame = CGRectMake(i * parentViewFrame.size.width, 0, parentViewFrame.size.width, parentViewFrame.size.height);
    }
    
    [self addSubview:_segmentedControlBottomStick];
    [_delegateParentView addSubview:self];
    for (UIView *thisView in _contentViewsContainer) {
        [_scrollView addSubview:thisView];
    }
    [_delegateParentView addSubview:_scrollView];
}

-(void)segmentedControlValueDidChange:(UISegmentedControl *)segmentControl{
    NSInteger selectedIndex = segmentControl.selectedSegmentIndex;
    CGPoint contenOffsetNext = CGPointMake(selectedIndex * _delegateParentView.frame.size.width, _scrollView.contentOffset.y);
    [_scrollView setContentOffset:contenOffsetNext animated:YES];
    //slide bottom line of segmented control
    [UIView animateWithDuration:.5 animations:^{
        CGFloat eachSegmentWidth = [self.subviews objectAtIndex:0].frame.size.width;
        CGRect bottomLineFrame = _segmentedControlBottomStick.frame;
        _segmentedControlBottomStick.frame = CGRectMake(selectedIndex * eachSegmentWidth + 5, bottomLineFrame.origin.y, bottomLineFrame.size.width, bottomLineFrame.size.height);
    }];
}

- (void)viewChangedNotification:(NSNotification *)event{
    NSInteger currentPage = [[event.object objectForKey:@"CurrentPage"] integerValue];
    if (_scrollView.previousPage == currentPage)
        [UIView animateWithDuration:.3 animations:^{
            CGRect bottomStickFrame = _segmentedControlBottomStick.frame;
            _segmentedControlBottomStick.frame = CGRectMake(bottomStickFrame.origin.x, bottomStickFrame.origin.y - 5, bottomStickFrame.size.width, bottomStickFrame.size.height);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:.3 animations:^{
                CGRect bottomStickFrame = _segmentedControlBottomStick.frame;
                _segmentedControlBottomStick.frame = CGRectMake(bottomStickFrame.origin.x, bottomStickFrame.origin.y + 5, bottomStickFrame.size.width, bottomStickFrame.size.height);
            }];
        }];
    else
        [UIView animateWithDuration:.5 animations:^{
            CGFloat eachSegmentWidth = [self.subviews objectAtIndex:0].frame.size.width;
            CGRect bottomStickFrame = _segmentedControlBottomStick.frame;
            _segmentedControlBottomStick.frame = CGRectMake(currentPage * eachSegmentWidth + 5, bottomStickFrame.origin.y, bottomStickFrame.size.width, bottomStickFrame.size.height);
        }];
}

-(void)setBottomStickColor:(UIColor *)desiredColor{
    _segmentedControlBottomStick.backgroundColor = desiredColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
