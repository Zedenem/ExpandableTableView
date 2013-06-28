//
//  ViewController.m
//  ExpandableTableView
//
//  Created by Zouhair on 17/05/13.
//  Copyright (c) 2013 Zedenem. All rights reserved.
//

#import "ViewController.h"

#import "ExpandableTableView.h"
#import "CustomExpandableSectionHeader.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

#define kNumberOfRowsInSection(section) section*2+2

#pragma mark View Lifecycle
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 10;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [NSString stringWithFormat:@"Section %d", section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger numberOfSections = kNumberOfRowsInSection(section);
	if ([tableView isKindOfClass:[ExpandableTableView class]]) {
		ExpandableTableView *expandableTableView = (ExpandableTableView *)tableView;
		if (![expandableTableView isExpanded:section]) {
			numberOfSections -= [[expandableTableView.delegate expandableTableView:expandableTableView expandableRowsForSection:section] count];
		}
	}
	return numberOfSections;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"CellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	[cell.textLabel setText:[NSString stringWithFormat:@"{%d, %d}", indexPath.row, indexPath.section]];
	
	return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 34.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	id view = nil;
	if ([tableView isKindOfClass:[ExpandableTableView class]]) {
		ExpandableTableView *expandableTableView = (ExpandableTableView *)tableView;
		view = [expandableTableView viewForHeaderInSection:section];
	}
	return view;
}

#pragma mark ExpandableTableViewDelegate
- (ExpandableSectionHeader *)expandableTableView:(ExpandableTableView *)expandableTableView viewForHeaderInSection:(NSInteger)section {
	ExpandableSectionHeader *sectionHeader = [expandableTableView sectionHeaderViewWithClass:[CustomExpandableSectionHeader class]];
	
	[sectionHeader.textLabel setText:[expandableTableView.dataSource tableView:expandableTableView titleForHeaderInSection:section]];
	
	return sectionHeader;
}
- (void)expandableTableView:(ExpandableTableView *)expandableTableView sectionTapped:(NSInteger)section {
}
- (NSArray *)expandableTableView:(ExpandableTableView *)expandableTableView expandableRowsForSection:(NSInteger)section {
	NSMutableArray *expandableRows = [NSMutableArray array];
	for (int i = 0; i < kNumberOfRowsInSection(section); i++) {
		[expandableRows addObject:[NSIndexPath indexPathForRow:i inSection:section]];
	}
	return [NSArray arrayWithArray:expandableRows];
}
- (UITableViewRowAnimation)expandableTableView:(ExpandableTableView *)expandableTableView rowsDeletionAnimationForSection:(NSInteger)section {
	return UITableViewRowAnimationTop;
}
- (UITableViewRowAnimation)expandableTableView:(ExpandableTableView *)expandableTableView rowsInsertionAnimationForSection:(NSInteger)section {
	return UITableViewRowAnimationBottom;
}

@end
