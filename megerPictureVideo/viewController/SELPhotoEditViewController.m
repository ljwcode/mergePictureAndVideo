//
//  SELPhotoEditViewController.m
//  megerPictureVideo
//
//  Created by 1 on 2020/11/16.
//

#import "SELPhotoEditViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SELBgCollectionViewCell.h"
#import "SELBgMusicCollectionViewCell.h"
#import "SELThumbnailCollectionViewCell.h"

static NSString *SELBgCollectionViewCellID = @"SELBgCollectionViewCell";

static NSString *SELBgMusicCollectionViewCellID = @"SELBgMusicCollectionViewCell";

static NSString *SELThumbnailCollectionViewCellID = @"SELThumbnailCollectionViewCell";

static NSString *SELThumbnailCollectionViewCellHeaderID = @"SELThumbnailCollectionViewCellHeaderID";

static NSString *SELThumbnailCollectionViewCellFooterID = @"SELThumbnailCollectionViewCellFooterID";


@interface SELPhotoEditViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *playerBgImgView;
@property (weak, nonatomic) IBOutlet UIButton *PlayerBtn;

@property (weak, nonatomic) IBOutlet UICollectionView *videoFpsView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SELSegmentControl;

@property (weak, nonatomic) IBOutlet UICollectionView *SELVideoBgView;

@property(nonatomic,strong)NSArray *bgImgArray;

@property(nonatomic,assign)CGSize itemSize;

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation SELPhotoEditViewController

-(void)viewDidLayoutSubviews{
    UIBarButtonItem *okBarItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(okEditHandle:)];
    self.navigationItem.rightBarButtonItem = okBarItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.videoFpsView registerNib:[UINib nibWithNibName:SELThumbnailCollectionViewCellID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:SELThumbnailCollectionViewCellID];
    [self.videoFpsView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SELThumbnailCollectionViewCellHeaderID];
    [self.videoFpsView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SELThumbnailCollectionViewCellFooterID];
    
    [self.SELVideoBgView registerNib:[UINib nibWithNibName:SELBgCollectionViewCellID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:SELBgCollectionViewCellID];
    [self.SELVideoBgView registerNib:[UINib nibWithNibName:SELBgMusicCollectionViewCellID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:SELBgMusicCollectionViewCellID];
    self.SELVideoBgView.delegate = self;
    self.SELVideoBgView.dataSource = self;
    self.itemSize = CGSizeMake(kScreenWidth/4.0, kScreenWidth/4.0);
    self.SELVideoBgView.layer.borderColor = [UIColor redColor].CGColor;
    self.SELVideoBgView.layer.borderWidth = 2.f;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ------ UICollectionView delegate && dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.bgImgArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *resultCell = nil;
    if(collectionView == self.SELVideoBgView){
        SELBgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SELBgCollectionViewCellID forIndexPath:indexPath];
        [cell.SELBgImgView setImage:[UIImage imageNamed:self.bgImgArray[indexPath.row]]];
        resultCell = cell;
    }
    
    
    return resultCell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemSize;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark ------ 响应事件

-(void)okEditHandle:(id)sender{
    
}

#pragma mark ----- lazy load
-(NSArray *)bgImgArray{
    if(!_bgImgArray){
        _bgImgArray = [NSArray arrayWithObjects:@"bg01.png",@"bg02.png",@"bg03.png", nil];
    }
    return _bgImgArray;
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
