//
//  ExpandableSectionHeader.m
//  ExpandableTableView
//
//  Created by Zouhair on 17/05/13.
//  Copyright (c) 2013 Zedenem. All rights reserved.
//

#import "ExpandableSectionHeader.h"

@interface ExpandableSectionHeader ()

#pragma mark Properties
@property (nonatomic, assign) NSInteger currentSection;

@end

@implementation ExpandableSectionHeader

#pragma mark Properties
@synthesize textLabel = _textLabel;
- (UILabel *)textLabel {
	if (!_textLabel) {
		_textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[self addSubview:_textLabel];
		
		[_textLabel setBackgroundColor:[UIColor clearColor]];
	}
	return _textLabel;
}
@synthesize currentSection = _currentSection;

#pragma mark Lifecycle
- (void)setup {
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOccurred:)];
	[self addGestureRecognizer:tapGestureRecognizer];
	[tapGestureRecognizer release];
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self setup];
    }
    return self;
}
- (void)awakeFromNib {
	[super awakeFromNib];
	[self setup];
}
- (void)dealloc {
	[_textLabel release];
	[super dealloc];
}
- (void)layoutSubviews {
	[super layoutSubviews];
	CGFloat textLabelHorizontalMargin = 5.0;
	[self.textLabel setFrame:CGRectMake(textLabelHorizontalMargin,
										0.0,
										self.bounds.size.width - textLabelHorizontalMargin*2,
										self.bounds.size.height)];
}

#pragma mark Selections management methods
- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
}
- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
}
- (void)setEnabled:(BOOL)enabled {
	[super setEnabled:enabled];
}

#pragma mark UITapGestureRecognizer method
- (void)tapOccurred:(UITapGestureRecognizer *)tapGestureRecognizer {
	if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
		[self sendActionsForControlEvents:UIControlEventTouchUpInside];
	}
}

@end
