//
// RETableViewBoolCell.m
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "RETableViewBoolCell.h"
#import "RETableViewManager.h"

@interface RETableViewBoolCell ()

@property (strong, readwrite, nonatomic) UISwitch *switchView;

@end

@implementation RETableViewBoolCell

#pragma mark -
#pragma mark Lifecycle

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.switchView = [[UISwitch alloc] init];
    self.switchView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.switchView addTarget:self action:@selector(switchValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.switchView];
}

- (void)cellWillAppear
{
    [self.contentView removeConstraints:self.contentView.constraints];
    CGFloat margin = (REUIKitIsFlatMode() && self.section.style.contentViewMargin <= 0) ? 15.0 : 10.0;
    NSDictionary *metrics = @{@"margin": @(margin)};
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.switchView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0
                                                                  constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.switchView
                                  attribute:NSLayoutAttributeRight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.contentView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1.0f
                                   constant:-15.0f]];
    
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.text = self.item.title;
    self.switchView.on = self.item.value;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width - self.switchView.frame.size.width - self.section.style.contentViewMargin - 10.0, self.textLabel.frame.size.height);
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[self.tableViewManager.tableView indexPathForCell:self]];
}

#pragma mark -
#pragma mark Handle events

- (void)switchValueDidChange:(UISwitch *)switchView
{
    self.item.value = switchView.isOn;
    if (self.item.switchValueChangeHandler)
        self.item.switchValueChangeHandler(self.item);
}

@end
