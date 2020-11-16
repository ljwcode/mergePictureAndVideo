//
//  SELPhotoViewController.m
//  megerPictureVideo
//
//  Created by 1 on 2020/11/12.
//

#import "SELPhotoViewController.h"
#import "assetModel.h"
#import <Photos/Photos.h>
#import "assetPhotoCollectionViewCell.h"
#import <MBProgressHUD_Add/UIViewController+MBPHUD.h>
#import "SELPhotoEditViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString *PhotoCollectionViewID =  @"assetPhotoCollectionViewCell";

@interface SELPhotoViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *assetsCollectionView;

@property (weak, nonatomic) IBOutlet UILabel *selVideoLabel;
@property (weak, nonatomic) IBOutlet UILabel *selPictureLabel;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;

@property(nonatomic,strong)NSMutableArray<assetModel *> *dataArray;

@property(nonatomic,strong)NSMutableArray<assetModel *> *originDataArray;

@property(nonatomic,strong)NSMutableArray<assetModel *> *selectedDataArray;

@property(nonatomic,assign)BOOL onlyPicture;

@property(nonatomic,assign)CGSize itemSize;

@property(nonatomic,assign)NSInteger selectedItemCount;

@end

@implementation SELPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.assetsCollectionView.delegate = self;
    self.assetsCollectionView.dataSource = self;
    self.itemSize = CGSizeMake(kScreenWidth/5.f, kScreenWidth/5.f);
    [self.assetsCollectionView registerNib:[UINib nibWithNibName:PhotoCollectionViewID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:PhotoCollectionViewID];
    
    self.completeBtn.layer.cornerRadius = 8.f;
    self.completeBtn.layer.maskedCorners = YES;
    [self.completeBtn addTarget:self action:@selector(completeHandle:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showHUDMessage:@"loading..."];
    if(self.dataArray.count == 0){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized){
                NSLog(@"已授权");
                [self loadPHotoData];
            }else{
                if(status == PHAuthorizationStatusDenied){
                    NSLog(@"photo denied");
                }else if(status == PHAuthorizationStatusRestricted){
                    NSLog(@"photo restricted");
                }else if(status == PHAuthorizationStatusNotDetermined){
                    NSLog(@"photo determined");
                }
            }
        }];
    }
}

#pragma mark ----- UICollectionViewDelegate && UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    assetPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCollectionViewID forIndexPath:indexPath];
    if(_dataArray[indexPath.row].asset.mediaType == PHAssetMediaTypeVideo){
        cell.assetTimeLabel.hidden = NO;
        cell.assetTimeLabel.text = _dataArray[indexPath.row].durationDesc ?: @"00:00";
    }else{
        cell.assetTimeLabel.hidden = YES;
    }
    [cell.imageView setImage:_dataArray[indexPath.row].image];
    cell.selectBtn.selected = _dataArray[indexPath.row].isSelected;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray[indexPath.row].isSelected){
        _dataArray[indexPath.row].isSelected = NO;
        [_selectedDataArray removeObject:_dataArray[indexPath.row]];
        _selectedItemCount--;
        [_assetsCollectionView reloadItemsAtIndexPaths:@[indexPath]];
        [self updateSelectLabelDisplay];
        [self.assetsCollectionView reloadData];
    }else if(_selectedItemCount < 99){
        assetModel *model = _dataArray[indexPath.row];
        model.isSelected = YES;
        _selectedItemCount ++;
        [_selectedDataArray addObject:model];
        [_assetsCollectionView reloadItemsAtIndexPaths:@[indexPath]];
        [self updateSelectLabelDisplay];
        [self.assetsCollectionView reloadData];
    }
}

-(void)updateSelectLabelDisplay{
    int picture = 0;
    int video = 0;
    for(assetModel *model in _selectedDataArray){
        if(model.asset.mediaType == PHAssetMediaTypeVideo){
            video ++;
        }else{
            picture ++;
        }
    }
    self.selVideoLabel.text = [NSString stringWithFormat:@"视频(%d)个",video];
    self.selPictureLabel.text = [NSString stringWithFormat:@"照片(%d)张",picture];
}

#pragma mark ---- UICollectionViewFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _itemSize;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

#pragma mark ---- load data
-(void)loadPHotoData{
    PHFetchOptions*options = [[PHFetchOptions alloc]init];
    options.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    PHFetchResult *fetchResult = self.onlyPicture?[PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:options]:[PHAsset fetchAssetsWithOptions:options];
    CGSize targetSize = CGSizeMake(_itemSize.width*[UIScreen mainScreen].scale, _itemSize.height*[UIScreen mainScreen].scale);
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    imageRequestOptions.synchronous = NO;
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int x = 0; x<fetchResult.count; x++){
        PHAsset *targetAsset = fetchResult[x];
        assetModel *model = [assetModel assetModelWithPHAsset:targetAsset];
        [resultArray insertObject:model atIndex:0];
        [[PHImageManager defaultManager]requestImageForAsset:model.asset targetSize:targetSize contentMode:PHImageContentModeDefault options:imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            model.image = result;
        }];
    }
    
    _originDataArray = resultArray;
    _dataArray = _originDataArray;
    _selectedDataArray = [NSMutableArray array];
    dispatch_sync(dispatch_get_main_queue(),^{
        [_assetsCollectionView reloadData];
        [_assetsCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_dataArray.count - 1 inSection:0]atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        [self showHUDMessage:@"加载完成"];
    });
    
}

#pragma mark ------ 点击事件

-(void)completeHandle:(UIButton *)sender{
    if(self.selectedDataArray.count > 0){
        NSLog(@"已选择图片/视频%@",self.selectedDataArray);
        SELPhotoEditViewController *SELPhotoEditVC = [[SELPhotoEditViewController alloc]init];
        [self.navigationController pushViewController:SELPhotoEditVC animated:YES];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
