//
//  assetModel.m
//  megerPictureVideo
//
//  Created by 1 on 2020/11/12.
//

#import "assetModel.h"

@implementation assetModel

-(void)setAsset:(PHAsset *)asset{
    _asset = asset;
    if(asset != nil && asset.mediaType == PHAssetMediaTypeVideo){
        self.durationDesc = [NSString stringWithFormat:@"%02ld:%02ld",(NSInteger)_asset.duration/60,(NSInteger)_asset.duration%60];
    }
}

+(assetModel *)assetModelWithPHAsset:(PHAsset *)asset{
    assetModel *model = [[assetModel alloc]init];
    model.createDate = [asset.creationDate copy];
    model.location = [asset.location copy];
    model.asset = asset;
    
    return model;
}

@end
