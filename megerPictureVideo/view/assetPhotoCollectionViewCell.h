//
//  assetPhotoCollectionViewCell.h
//  megerPictureVideo
//
//  Created by 1 on 2020/11/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface assetPhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UILabel *assetTimeLabel;

@end

NS_ASSUME_NONNULL_END
