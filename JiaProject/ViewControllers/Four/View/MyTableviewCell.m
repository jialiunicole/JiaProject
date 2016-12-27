//
//  MyTableviewCell.m
//  JiaProject
//
//  Created by 刘佳 on 16/12/22.
//  Copyright © 2016年 7k7k. All rights reserved.
//

#import "MyTableviewCell.h"

@implementation MyTableviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"hahhahhaa");
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSLog(@"style=%ld,reuseidentifier=%@",(long)style,reuseIdentifier);
    }
    return self;
}

-(void)layoutIfNeeded{
    [super layoutIfNeeded];
    if (self.imageView.image == nil) {
        return;
    }
    
    self.imageView.y = 5;
    self.imageView.height = self.contentView.height-10;
    self.imageView.width = self.imageView.height;
    self.imageView.x = 30;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 30;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
