//
//  ExpandableSectionHeader.h
//  ExpandableTableView
//
//  Created by Zouhair on 17/05/13.
//  Copyright (c) 2013 Zedenem. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandableSectionHeader : UIControl

#pragma mark Properties
@property (nonatomic, retain) UILabel *textLabel;

#pragma mark Lifecycle
- (void)setup;

@end
