//
//  ViewController.m
//  SBFlowView
//
//  Created by JK.Peng on 13-1-30.
//  Copyright (c) 2013年 njut. All rights reserved.
//

#import "ViewController.h"
#import "SBPageFlowView.h"

@interface ViewController ()<SBPageFlowViewDelegate,SBPageFlowViewDataSource>{
    NSArray *_imageArray;
    
    NSInteger    _currentPage;
    
    SBPageFlowView  *_flowView;
}

@end

@implementation ViewController

- (void)dealloc{
    [_imageArray release], _imageArray = nil;
    [_flowView release], _flowView = nil;
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _imageArray = [[NSArray alloc] initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",nil];
    
    _currentPage = 0;
        
    _flowView = [[SBPageFlowView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 240)];
    _flowView.delegate = self;
    _flowView.dataSource = self;
    _flowView.minimumPageAlpha = 0.6;
    _flowView.minimumPageScale = 0.96;
    _flowView.defaultImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]] autorelease];
    [self.view addSubview:_flowView];
    
    [_flowView reloadData];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(130, 260, 60, 30);
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(scropTo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];    
}

- (void)scropTo:(id)sender{
    [_flowView scrollToNextPage];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - PagedFlowView Datasource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(SBPageFlowView *)flowView{
    return [_imageArray count];
}

- (CGSize)sizeForPageInFlowView:(SBPageFlowView *)flowView;{
    return CGSizeMake(240, 180);
}

//返回给某列使用的View
- (UIView *)flowView:(SBPageFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView) {
        imageView = [[[UIImageView alloc] init] autorelease];
        imageView.layer.masksToBounds = YES;
    }
    
    imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:index]];
    return imageView;
}

#pragma mark - PagedFlowView Delegate
- (void)didReloadData:(UIView *)cell cellForPageAtIndex:(NSInteger)index
{
    UIImageView *imageView = (UIImageView *)cell;
    imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:index]];
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(SBPageFlowView *)flowView {
    NSLog(@"Scrolled to page # %d", pageNumber);
    _currentPage = pageNumber;
}

- (void)didSelectItemAtIndex:(NSInteger)index inFlowView:(SBPageFlowView *)flowView
{
    NSLog(@"didSelectItemAtIndex: %d", index);
    
    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@""
                                                     message:[NSString stringWithFormat:@"您当前选择的是第 %d 个图片",index]
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles: nil];
    [alert show];
    [alert release];
    
}
@end
