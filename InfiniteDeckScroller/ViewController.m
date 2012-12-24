//
//  ViewController.m
//  SCROLL
//
//  Created by Wibbitz on 12/16/12.
//  Copyright (c) 2012 Wibbitz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) int currentCardIndex;
@property (nonatomic, strong) NSArray *cardsViewsArray;

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
	
	self.cardsViewsArray = [NSArray arrayWithObjects:[self labelWithText:@"0" withBgColor:[UIColor redColor]],
							[self labelWithText:@"1" withBgColor:[UIColor orangeColor]],
							[self labelWithText:@"2" withBgColor:[UIColor yellowColor]],
							[self labelWithText:@"3" withBgColor:[UIColor greenColor]],
							[self labelWithText:@"4" withBgColor:[UIColor blueColor]],
							[self labelWithText:@"5" withBgColor:[UIColor purpleColor]],
							[self labelWithText:@"6" withBgColor:[UIColor brownColor]],
							[self labelWithText:@"7" withBgColor:[UIColor lightGrayColor]],
							[self labelWithText:@"8" withBgColor:[UIColor grayColor]], nil];

	scroll1.contentSize = CGSizeMake(self.view.frame.size.width * 2, self.view.frame.size.height * 1);
	scroll1.tag = BOTTOM;
	scroll1.pagingEnabled = YES;
	scroll1.bounces = NO;
	scroll1.delegate = self;
	[scroll1 addSubview:[self.cardsViewsArray objectAtIndex:2]];
	[scroll1 setContentOffset:CGPointMake(0, 0)];
	
	scroll2.contentSize = CGSizeMake(self.view.frame.size.width * 2, self.view.frame.size.height * 1);
	scroll2.tag = MIDDLE;
	scroll2.pagingEnabled = YES;
	scroll2.bounces = NO;
	scroll2.delegate = self;
	[scroll2 addSubview:[self.cardsViewsArray objectAtIndex:1]];
	[scroll2 setContentOffset:CGPointMake(0, 0)];
	
	scroll3.contentSize = CGSizeMake(self.view.frame.size.width * 2, self.view.frame.size.height * 1);
	scroll3.tag = TOP;
	scroll3.pagingEnabled = YES;
	scroll3.bounces = NO;
	scroll3.delegate = self;
	[scroll3 addSubview:[self.cardsViewsArray objectAtIndex:0]];
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
	
	self.currentCardIndex = 1;
}

- (UILabel*)labelWithText:(NSString*)text withBgColor:(UIColor*)color{
	UILabel *lbl = [[UILabel alloc] initWithFrame:self.view.bounds];
	lbl.textAlignment = NSTextAlignmentCenter;
	lbl.backgroundColor = color;
	lbl.text = text;
	return lbl;
}

- (UILabel*)labelForScrollView:(UIScrollView*)scrollView withBgColor:(UIColor*)color{
	UILabel *lbl = [[UILabel alloc] initWithFrame:scrollView.bounds];
	lbl.textAlignment = NSTextAlignmentCenter;
	lbl.backgroundColor = color;
	lbl.text = [NSString stringWithFormat:@"ScrollView: %d", scrollView.tag];
	return lbl;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	
	UIScrollView *newMiddleScrollView, *newBottomScrollView, *newTopScrollView;
	
	int lastindex = [self.cardsViewsArray indexOfObject:[self.cardsViewsArray lastObject]];
	
	// swipe right
	
	if (scrollView.contentOffset.x == 320 && scrollView.tag == MIDDLE) {
	
		newMiddleScrollView = (UIScrollView*)[self.view viewWithTag:BOTTOM];
		newTopScrollView = (UIScrollView*)[self.view viewWithTag:MIDDLE];
		newBottomScrollView = (UIScrollView*)[self.view viewWithTag:TOP];

		self.currentCardIndex ++;
		if (self.currentCardIndex == lastindex + 1) self.currentCardIndex = 0;
	}
	
	// swipe left
	
	else if (scrollView.contentOffset.x == 0 && scrollView.tag == TOP) {
		
		newMiddleScrollView = (UIScrollView*)[self.view viewWithTag:TOP];
		newTopScrollView = (UIScrollView*)[self.view viewWithTag:BOTTOM];
		newBottomScrollView = (UIScrollView*)[self.view viewWithTag:MIDDLE];

		self.currentCardIndex --;
		if (self.currentCardIndex == -1) self.currentCardIndex = lastindex;
	}

	else {
		return;
	}
	
	int nextCardIndex = self.currentCardIndex + 1;
	int prevCardIndex = self.currentCardIndex - 1;
	
	if (prevCardIndex == -1) prevCardIndex = lastindex;
	if (nextCardIndex == lastindex + 1) nextCardIndex = 0;
	NSLog(@"prevIndex: %d, self.currentIndex: %d, nextIndex: %d ",prevCardIndex, self.currentCardIndex, nextCardIndex);	
	
	[newBottomScrollView addSubview:[self.cardsViewsArray objectAtIndex:nextCardIndex]];
	[newTopScrollView addSubview:[self.cardsViewsArray objectAtIndex:prevCardIndex]];
	
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
