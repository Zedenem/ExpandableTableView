//
//  ExpandableTableView.h
//  ExpandableTableView
//
//  Created by Zouhair on 17/05/13.
//  Copyright (c) 2013 Zedenem. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExpandableTableView;
@class ExpandableSectionHeader;

@protocol ExpandableTableViewDelegate <UITableViewDelegate>

- (ExpandableSectionHeader *)expandableTableView:(ExpandableTableView *)expandableTableView viewForHeaderInSection:(NSInteger)section;

- (void)expandableTableView:(ExpandableTableView *)expandableTableView sectionTapped:(NSInteger)section;

- (NSArray *)expandableTableView:(ExpandableTableView *)expandableTableView expandableRowsForSection:(NSInteger)section;

- (UITableViewRowAnimation)expandableTableView:(ExpandableTableView *)expandableTableView rowsDeletionAnimationForSection:(NSInteger)section;
- (UITableViewRowAnimation)expandableTableView:(ExpandableTableView *)expandableTableView rowsInsertionAnimationForSection:(NSInteger)section;

@end

@interface ExpandableTableView : UITableView

#pragma mark Properties
@property (nonatomic, assign) id<ExpandableTableViewDelegate> delegate;

#pragma mark Section Headers Views management methods
- (ExpandableSectionHeader *)viewForHeaderInSection:(NSInteger)section;
- (BOOL)isExpanded:(NSInteger)section;

#pragma mark Section Headers Views Reusability management methods
- (ExpandableSectionHeader *)sectionHeaderViewWithClass:(Class)sectionHeaderViewClass;

@end
