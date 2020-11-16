//
//  SELBgCollectionViewCell.m
//  megerPictureVideo
//
//  Created by 1 on 2020/11/16.
//

#import "SELBgCollectionViewCell.h"

@implementation SELBgCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _SELBgView.layer.borderColor = [UIColor blueColor].CGColor;
    _SELBgView.layer.borderWidth = 4.f;
    // Initialization code
}

@end
