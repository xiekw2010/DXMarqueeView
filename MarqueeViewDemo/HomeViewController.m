//
//  HomeViewController.m
//  MarqueeViewDemo
//
//  Created by xiekw on 8/14/14.
//  Copyright (c) 2014 xiekw. All rights reserved.
//

#import "HomeViewController.h"
#import "DXMarqueeView.h"

@interface HomeViewController ()

@property (nonatomic, strong) DXMarqueeView *imageMarqueeView;
@property (nonatomic, strong) DXMarqueeView *textMarqueeView;
@property (nonatomic, strong) DXMarqueeView *titleMarqueeView;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.imageMarqueeView = [[DXMarqueeView alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
    self.imageMarqueeView.spaceBetweenRepeats = 40.0;
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horse.png"]];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.imageMarqueeView.viewToScroll = imageV;
    [self.imageMarqueeView beginScrollingToLeft:YES];
    [self.view addSubview:self.imageMarqueeView];

    
    self.textMarqueeView = [[DXMarqueeView alloc] initWithFrame:CGRectMake(10, 200, 300, 50)];
    self.textMarqueeView.spaceBetweenRepeats = 10.0;
    self.textMarqueeView.speed = 2.0;
    self.textMarqueeView.backgroundColor = [UIColor blackColor];
    UILabel *lb = [[UILabel alloc] initWithFrame:self.textMarqueeView.bounds];
    lb.text = @"Hello dear, Welcome to use it!!";
    lb.textColor = [UIColor whiteColor];
    lb.backgroundColor = [UIColor clearColor];
    self.textMarqueeView.viewToScroll = lb;
    [self.textMarqueeView beginScrollingToLeft:NO];
    [self.view addSubview:self.textMarqueeView];

    
    self.titleMarqueeView = [[DXMarqueeView alloc] initWithFrame:CGRectMake(0, 0, 130, 44)];
    UILabel *tlb = [[UILabel alloc] initWithFrame:self.titleMarqueeView.bounds];
    tlb.text = @"DXMarqueeView";
    self.titleMarqueeView.viewToScroll = tlb;
    self.navigationItem.titleView = self.titleMarqueeView;
    [self.titleMarqueeView beginScrollingToLeft:YES];
    
    
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
    [stop setTitle:@"Stop" forState:UIControlStateNormal];
    [stop setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    stop.frame = CGRectMake(200, 400, 80, 44);
    [stop addTarget:self action:@selector(stopMarquee) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    [start setTitle:@"start" forState:UIControlStateNormal];
    [start setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    start.frame = CGRectMake(10, 400, 80, 44);
    [start addTarget:self action:@selector(startMarquee) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
}

- (void)startMarquee
{
    [self.imageMarqueeView beginScrollingToLeft:YES];
    [self.textMarqueeView beginScrollingToLeft:NO];
    [self.titleMarqueeView beginScrollingToLeft:YES];
}

- (void)stopMarquee
{
    [self.imageMarqueeView stopScrolling];
    [self.textMarqueeView stopScrolling];
    [self.titleMarqueeView stopScrolling];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
