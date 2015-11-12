//
//  ELSegmentedControl.h
//  ELSegmentedControl
//
//  Created by LuEvan on 2015/10/4.
//  Copyright © 2015年 EvanLu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SEGMENTED_CONTROL_DEFAULT_HEIGHT      50.f
#define PAGE_CONTROL_HEIGHT                   10.f
#define SEGMENTED_CONTROL_BOTTOM_LINE_HEIGHT  5.f

@interface ELSegmentedControl : UISegmentedControl

/**
 *  you need to create each view corresponds with each item of segmented control before initializing ELSegmentedControl.
 *
 *  @param items              An array of NSString objects (for segment titles) or UIImage objects (for segment image)
 *  @param delegateParentView The root view which you want segmented control and scroll view being added.
 *  @param contentViews       An array of each view corresponds with each item
 *
 *  @return self
 */
-(id)initWithItemsContentViews:(NSArray *)items delegateParentView:(UIView *)delegateParentView contentViews:(NSMutableArray *)contentViews;

/**
 *  change the color to your desire.
 *
 *  @param desiredColor UIColor
 */
-(void)setBottomStickColor:(UIColor *)desiredColor;
@end
