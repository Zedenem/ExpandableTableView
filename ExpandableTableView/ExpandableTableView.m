//
//  ExpandableTableView.m
//  ExpandableTableView
//
//  Created by Zouhair on 17/05/13.
//  Copyright (c) 2013 Zedenem. All rights reserved.
//

#import "ExpandableTableView.h"
#import "ExpandableSectionHeader.h"

@interface ExpandableSectionHeader ()

@property (nonatomic, assign) NSInteger currentSection;

@end

@interface ExpandableTableView ()

#pragma mark Section Headers Views management methods
@property (nonatomic, retain) NSMutableArray *expandedSections;

@end

@implementation ExpandableTableView

#pragma mark Properties
@dynamic delegate;

#pragma mark Lifecycle
- (void)dealloc {
	[_expandedSections release];
	[super dealloc];
}

#pragma mark Data Reloading
- (void)reloadData {
	[self setExpandedSections:nil];
	[super reloadData];
}

#pragma mark Section Headers Views management methods
- (ExpandableSectionHeader *)viewForHeaderInSection:(NSInteger)section {
	ExpandableSectionHeader *viewForHeaderInSection = nil;
	
	if ([self.delegate respondsToSelector:@selector(expandableTableView:viewForHeaderInSection:)]) {
		viewForHeaderInSection = [self.delegate expandableTableView:self viewForHeaderInSection:section];
		[viewForHeaderInSection setCurrentSection:section];
		[viewForHeaderInSection setSelected:![self isExpanded:section]];
	}
	
	return viewForHeaderInSection;
}

@synthesize expandedSections = _expandedSections;
- (NSMutableArray *)expandedSections {
	if (!_expandedSections) {
		_expandedSections = [[NSMutableArray alloc] init];
		for (int i = 0; i < [self numberOfSections]; i++) {
			if ([self.delegate respondsToSelector:@selector(expandableTableView:sectionExpandedByDefault:)]
				&& [self.delegate expandableTableView:self sectionExpandedByDefault:i]) {
				[_expandedSections addObject:[NSNumber numberWithInt:i]];
			}
		}
	}
	return _expandedSections;
}
- (BOOL)isExpanded:(NSInteger)section {
	return [self.expandedSections containsObject:[NSNumber numberWithInt:section]];
}

#pragma mark Section Headers Views Reusability management methods

- (ExpandableSectionHeader *)sectionHeaderViewWithClass:(Class)sectionHeaderViewClass {
	ExpandableSectionHeader *sectionHeaderView = nil;
	
	[sectionHeaderView setCurrentSection:NSNotFound];
	
	if (!sectionHeaderView) {
		if (sectionHeaderViewClass == NULL) {
			sectionHeaderViewClass = [ExpandableSectionHeader class];
		}
		sectionHeaderView = [[[sectionHeaderViewClass alloc] initWithFrame:CGRectZero] autorelease];
		[sectionHeaderView addTarget:self action:@selector(viewForHeaderInSectionTapped:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return sectionHeaderView;
}

#pragma mark Section Expansion methods
- (void)viewForHeaderInSectionTapped:(ExpandableSectionHeader *)sectionHeaderView {
	NSInteger tappedSection = sectionHeaderView.currentSection;
	if ([self.delegate respondsToSelector:@selector(expandableTableView:expandableRowsForSection:)]) {
		NSArray *expandableRows = [self.delegate expandableTableView:self expandableRowsForSection:tappedSection];
		UITableViewRowAnimation rowAnimation = UITableViewRowAnimationAutomatic;
		if ([self isExpanded:tappedSection]) {
			if ([self.delegate respondsToSelector:@selector(expandableTableView:rowsDeletionAnimationForSection:)]) {
				rowAnimation = [self.delegate expandableTableView:self rowsDeletionAnimationForSection:tappedSection];
			}
			[self.expandedSections removeObject:[NSNumber numberWithInt:tappedSection]];
			[self deleteRowsAtIndexPaths:expandableRows withRowAnimation:rowAnimation];
		}
		else {
			if ([self.delegate respondsToSelector:@selector(expandableTableView:rowsInsertionAnimationForSection:)]) {
				rowAnimation = [self.delegate expandableTableView:self rowsInsertionAnimationForSection:tappedSection];
			}
			[self.expandedSections addObject:[NSNumber numberWithInt:tappedSection]];
			[self insertRowsAtIndexPaths:expandableRows withRowAnimation:rowAnimation];
		}
		[sectionHeaderView setSelected:![self isExpanded:tappedSection]];
	}
	if ([self.delegate respondsToSelector:@selector(expandableTableView:sectionTapped:)]) {
		[self.delegate expandableTableView:self sectionTapped:tappedSection];
	}
}

@end
