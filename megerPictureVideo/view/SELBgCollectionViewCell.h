//
//  SELBgCollectionViewCell.h
//  megerPictureVideo
//
//  Created by 1 on 2020/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SELBgCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *SELBgImgView;
@property (weak, nonatomic) IBOutlet UIView *SELBgView;
@property (weak, nonatomic) IBOutlet UILabel *SELBgImgNameLabel;


@end

NS_ASSUME_NONNULL_END
