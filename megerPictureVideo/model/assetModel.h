//
//  assetModel.h
//  megerPictureVideo
//
//  Created by 1 on 2020/11/12.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface assetModel : NSObject

@property(nonatomic,strong)PHAsset *asset;

@property(nonatomic,strong)CLLocation *location;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)NSDate *createDate;

@property(nonatomic,assign)BOOL isSelected;

@property(nonatomic,copy)NSString *durationDesc;

+(assetModel *)assetModelWithPHAsset:(PHAsset *)asset;

@end

NS_ASSUME_NONNULL_END
