//
//  WaterCollectionViewCell.m
//  Eyepetizer
//
//  Created by yilos on 15/8/27.
//  Copyright (c) 2015年 yilos. All rights reserved.
//

#import "WaterCell.h"
#import "Masonry.h"
#import "NSDate+DateTools.h"
#import "UIFont+eyepetizer.h"
#import "UIImageView+WebCache.h"

@interface WaterCell ()

@end

@implementation WaterCell {
    UILabel *titleLabel;
    UILabel *tagLabel;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.transform = CGAffineTransformMakeScale(1.34, 1.34);
        //_imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        titleLabel = [UILabel new];
        titleLabel.font = [UIFont FZSB_FontOfSize:16];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:titleLabel];
        tagLabel = [UILabel new];
        tagLabel.font = [UIFont FZSL_FontOfSize:12];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:tagLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(titleLabel.mas_bottom).offset(10);
        }];
    }
    return self;
}

- (void) setModel:(VideoModel *)model {
    if (!model) {
        return;
    }
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed]];
    titleLabel.text = model.title;
    tagLabel.text = [NSString stringWithFormat:@"#%@ / %@",model.category,[self formatterDuration:model.duration]];
}

- (NSString *)formatterDuration:(NSString *)duration{
    CGFloat timeInSec = [duration floatValue];
    NSInteger timeInMin = floorf(timeInSec/60.0);
    timeInSec = fmodf(timeInSec, 60);
    return [NSString stringWithFormat:@"%ld′%02.0f″",timeInMin,timeInSec];
}

@end
