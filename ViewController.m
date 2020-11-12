//
//  ViewController.m
//  megerPictureVideo
//
//  Created by 1 on 2020/11/12.
//

#import "ViewController.h"
#import "SELPhotoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)startBtn:(id)sender {
    SELPhotoViewController *SELPhotoVC = [[SELPhotoViewController alloc]init];
    [self.navigationController pushViewController:SELPhotoVC animated:YES];
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
