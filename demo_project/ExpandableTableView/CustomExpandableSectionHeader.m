//
//  CustomExpandableSectionHeader.m
//  ExpandableTableView
//
//  Created by Zouhair on 17/05/13.
//  Copyright (c) 2013 Zedenem. All rights reserved.
//

#import "CustomExpandableSectionHeader.h"

@implementation CustomExpandableSectionHeader

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor greenColor]];
		[self.textLabel setTextAlignment:UITextAlignmentRight];
    }
    return self;
}
- (void)awakeFromNib {
	[super awakeFromNib];
	[self setBackgroundColor:[UIColor greenColor]];
}
- (void)layoutSubviews {
	[super layoutSubviews];
	CGFloat textLabelHorizontalMargin = 20.0;
	[self.textLabel setFrame:CGRectMake(textLabelHorizontalMargin,
										0.0,
										self.bounds.size.width - textLabelHorizontalMargin*2,
										self.bounds.size.height)];
}

@end
