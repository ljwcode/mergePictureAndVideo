//
//  SELBgMusicCollectionViewCell.m
//  megerPictureVideo
//
//  Created by 1 on 2020/11/16.
//

#import "SELBgMusicCollectionViewCell.h"

@implementation SELBgMusicCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.SELBgMusicView.layer.borderColor = [UIColor blueColor].CGColor;
    self.SELBgMusicView.layer.borderWidth = 4.f;
    // Initialization code
}

@end
