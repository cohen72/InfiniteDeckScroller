//
//  ViewController.m
//  SCROLL
//
//  Created by Wibbitz on 12/16/12.
//  Copyright (c) 2012 Wibbitz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end



#define BOTTOM 1
#define MIDDLE 2
#define TOP 3
#define VERTICAL_SUB 4


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIScrollView *scroll1 = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	UIScrollView *scroll2 = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	UIScrollView *scroll3 = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	UIScrollView *scroll4 = [[UIScrollView alloc] initWithFrame:self.view.bounds];
	
	scroll1.contentSize = CGSizeMake(self.view.frame.size.width * 2, self.view.frame.size.height * 1);
	scroll1.tag = BOTTOM;
	scroll1.pagingEnabled = YES;
	scroll1.bounces = NO;
	scroll1.delegate = self;
	[scroll1 addSubview:[self labelForScrollView:scroll1 withBgColor:[UIColor redColor]]];
	[scroll1 setContentOffset:CGPointMake(0, 0)];
	
	scroll2.contentSize = CGSizeMake(self.view.frame.size.width * 2, self.view.frame.size.height * 1);
	scroll2.tag = MIDDLE;
	scroll2.pagingEnabled = YES;
	scroll2.bounces = NO;
	scroll2.delegate = self;
	[scroll2 addSubview:[self labelForScrollView:scroll2 withBgColor:[UIColor orangeColor]]];
	[scroll2 setContentOffset:CGPointMake(0, 0)];
	
	scroll3.contentSize = CGSizeMake(self.view.frame.size.width * 2, self.view.frame.size.height * 1);
	scroll3.tag = TOP;
	scroll3.pagingEnabled = YES;
	scroll3.bounces = NO;
	scroll3.delegate = self;
	[scroll3 addSubview:[self labelForScrollView:scroll3 withBgColor:[UIColor yellowColor]]];
	[scroll3 setContentOffset:CGPointMake(320, 0)];
	
	scroll4.contentSize = CGSizeMake(self.view.frame.size.width * 1, self.view.frame.size.height * 2);
	scroll4.delegate = self;
	scroll4.bounces = NO;
	scroll4.pagingEnabled = YES;
	scroll4.alwaysBounceVertical = NO;
	scroll4.tag = VERTICAL_SUB;
	
	[scroll4 addSubview:scroll1];
	[scroll1 addSubview:scroll2];
	[scroll2 addSubview:scroll3];
	[self.view addSubview:scroll4];
	
}

- (UILabel*)labelForScrollView:(UIScrollView*)scrollView withBgColor:(UIColor*)color{
	UILabel *lbl = [[UILabel alloc] initWithFrame:scrollView.bounds];
	lbl.textAlignment = NSTextAlignmentCenter;
	lbl.backgroundColor = color;
	lbl.text = [NSString stringWithFormat:@"ScrollView: %d", scrollView.tag];
	return lbl;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	
	NSLog(@"content offset: %f, tag: %d ", scrollView.contentOffset.x, scrollView.tag);
	
	UIScrollView *newMiddleScrollView, *newBottomScrollView, *newTopScrollView;
	
	// swipe left
	
	if (scrollView.contentOffset.x == 0 && scrollView.tag == TOP) {
		newMiddleScrollView = (UIScrollView*)[self.view viewWithTag:TOP];
		newTopScrollView = (UIScrollView*)[self.view viewWithTag:BOTTOM];
		newBottomScrollView = (UIScrollView*)[self.view viewWithTag:MIDDLE];
	}
	
	// swipe right
	
	else if (scrollView.contentOffset.x == 320 && scrollView.tag == MIDDLE) {
		newMiddleScrollView = (UIScrollView*)[self.view viewWithTag:BOTTOM];
		newTopScrollView = (UIScrollView*)[self.view viewWithTag:MIDDLE];
		newBottomScrollView = (UIScrollView*)[self.view viewWithTag:TOP];
	}
	else {
		return;
	}
	
	newMiddleScrollView.tag = MIDDLE;
	newBottomScrollView.tag = BOTTOM;
	newTopScrollView.tag = TOP;
	
	newBottomScrollView.contentOffset = CGPointMake(0, 0);
	newMiddleScrollView.contentOffset = CGPointMake(0, 0);
	newTopScrollView.contentOffset = CGPointMake(320, 0);
	
	UIScrollView *verticalScrollView_sub = (UIScrollView*)[self.view viewWithTag:VERTICAL_SUB];
	
	[verticalScrollView_sub addSubview:newBottomScrollView];
	[newBottomScrollView addSubview:newMiddleScrollView];
	[newMiddleScrollView addSubview:newTopScrollView];
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
