

//
//  CardDeckViewController.m
//  InfiniteDeckScroller
//
//  Created by Wibbitz on 12/25/12.
//  Copyright (c) 2012 Cohen72. All rights reserved.
//

#import "CardDeckViewController.h"
#import <QuartzCore/QuartzCore.h>


#define BOTTOM 111
#define MIDDLE 222
#define TOP 333
#define VERTICAL 999


@interface CardDeckViewController ()

@property (nonatomic, strong) NSIndexPath *currentCardIndexPath;

@end

@implementation CardDeckViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	[self reloadCardDeck];
}

- (void)reloadCardDeck{
	
	for (UIView *view in self.view.subviews) {
		[view removeFromSuperview];
	}
	
	NSMutableArray *verticalScrollArray = [NSMutableArray array];

		
		int numberOfCards = [self.delegate numberOfCardsInDeck:self];
		
		// normal sliding through deck (requires at least 3 cards in the deck)
		
		if (numberOfCards > 2) {

			NSMutableArray *horizontalScrollArray = [NSMutableArray array];
			
			// create three scroll views and add initial views from the datasource
			
			for (int row = 0; row < 3; row++) {

				UIScrollView *scroll = [[UIScrollView alloc] initWithFrame: self.view.bounds];//r];//
				scroll.contentSize = CGSizeMake(scroll.frame.size.width * 2, scroll.frame.size.height * 1);
				scroll.pagingEnabled = YES;
				scroll.bounces = NO;
				scroll.delegate = self;
				scroll.clipsToBounds = YES;
				[scroll addSubview:[self.delegate cardDeck:self cardViewForIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]];
				[horizontalScrollArray addObject:scroll];
			}
			
			NSLog(@"horizontalScrollArray: %@", horizontalScrollArray);
			// initialize the tags in reverse order, as the top scroll (3rd ScrollView on top of two others) will be actually the first item in the datasource
			
			UIScrollView *scroll1 = [horizontalScrollArray objectAtIndex:2];
			scroll1.tag = BOTTOM;
			[scroll1 setContentOffset:CGPointMake(0, 0)];
			UIScrollView *scroll2 = [horizontalScrollArray objectAtIndex:1];
			scroll2.tag = MIDDLE;
			[scroll2 setContentOffset:CGPointMake(0, 0)];
			UIScrollView *scroll3 = [horizontalScrollArray objectAtIndex:0];
			scroll3.tag = TOP;
			[scroll3 setContentOffset:CGPointMake(320, 0)];
			
			UIScrollView *scrollVertical = [[UIScrollView alloc] initWithFrame:self.view.bounds];
			scrollVertical.contentSize = CGSizeMake(self.view.frame.size.width * 1, self.view.frame.size.height * 2);
			scrollVertical.delegate = self;
			scrollVertical.bounces = NO;
			scrollVertical.pagingEnabled = YES;
			scrollVertical.alwaysBounceVertical = NO;
			scrollVertical.tag = VERTICAL;
			[scrollVertical setContentOffset:CGPointMake(0, 0)];
			
			[scrollVertical addSubview:scroll1];
			[scroll1 addSubview:scroll2];
			[scroll2 addSubview:scroll3];
			
			[verticalScrollArray addObject:scrollVertical];
			[self.view addSubview:scrollVertical];
			
		}
		else{
			//TODO: handle sliding between 2 cards, and presenting 1 card statically without sliding
		}

	self.currentCardIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
		[self.delegate performSelector:@selector(scrollViewDidScroll:) withObject:scrollView];
	}
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
	
	// swipe right, checking tag to indicate is a horizontal scroll movement
	if (scrollView.contentOffset.x == 320 && scrollView.tag == MIDDLE) {
		[self updateDeckForDirection:CardDeckSlideDirectionRight];
	}
	
	// swipe left, checking tag to indicate is a horizontal scroll movement
	else if (scrollView.contentOffset.x == 0 && scrollView.tag == TOP) {
		[self updateDeckForDirection:CardDeckSlideDirectionLeft];
	}
}


- (void)updateDeckForDirection:(CardDeckSlideDirection)slideDirection{
	
//	NSLog(@"section: %d, currentPathSection: %d", section, self.currentCardIndexPath.section);
	
	UIScrollView *newMiddleScrollView, *newBottomScrollView, *newTopScrollView;
	int lastindex = [self.delegate numberOfCardsInDeck:self] - 1;
	
	UIScrollView *verticalScrollView = (UIScrollView*)[self.view viewWithTag:VERTICAL];
	
	switch (slideDirection) {
		case CardDeckSlideDirectionRight:
			newMiddleScrollView = (UIScrollView*)[verticalScrollView viewWithTag:BOTTOM];
			newTopScrollView = (UIScrollView*)[verticalScrollView viewWithTag:MIDDLE];
			newBottomScrollView = (UIScrollView*)[verticalScrollView viewWithTag:TOP];
			self.currentCardIndexPath = [NSIndexPath indexPathForRow:self.currentCardIndexPath.row + 1 inSection:0];
			if (self.currentCardIndexPath.row == lastindex + 1)
				self.currentCardIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
			break;
			
		case CardDeckSlideDirectionLeft:
			newMiddleScrollView = (UIScrollView*)[verticalScrollView viewWithTag:TOP];
			newTopScrollView = (UIScrollView*)[verticalScrollView viewWithTag:BOTTOM];
			newBottomScrollView = (UIScrollView*)[verticalScrollView viewWithTag:MIDDLE];
			self.currentCardIndexPath = [NSIndexPath indexPathForRow:self.currentCardIndexPath.row - 1 inSection:0];
			if (self.currentCardIndexPath.row < 0)
				self.currentCardIndexPath = [NSIndexPath indexPathForRow:lastindex inSection:0];
			break;

		case CardDeckSlideDirectionUp:
			break;

		case CardDeckSlideDirectionDown:
			break;

		default:
			break;
	}
	
	if (slideDirection == CardDeckSlideDirectionRight || slideDirection == CardDeckSlideDirectionLeft) {
		
		// set the previous and next index paths
		
		NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:self.currentCardIndexPath.row + 1 inSection:0];
		NSIndexPath *prevIndexPath = [NSIndexPath indexPathForRow:self.currentCardIndexPath.row - 1 inSection:0];
		if (nextIndexPath.row > lastindex)	nextIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
		if (prevIndexPath.row < 0)			prevIndexPath = [NSIndexPath indexPathForRow:lastindex inSection:0];
//		NSLog(@"prev: %@, curr: %@, next: %@ ",prevIndexPath, self.currentCardIndexPath, nextIndexPath);
	
		// Clear all subviews from the next and previous views
		
		for (UIView *view in newBottomScrollView.subviews) {
			[view removeFromSuperview];
		}
		for (UIView *view in newTopScrollView.subviews) {
			[view removeFromSuperview];
		}
		
		// add the next and previous views to the scrollers
		
		[newBottomScrollView addSubview:[self.delegate cardDeck:self cardViewForIndexPath:nextIndexPath]];
		[newTopScrollView addSubview:[self.delegate cardDeck:self cardViewForIndexPath:prevIndexPath]];
		
		// add the datasource's views to the previous and next cards in the dec
		
		[newBottomScrollView removeFromSuperview];
		[newMiddleScrollView removeFromSuperview];
		[newTopScrollView removeFromSuperview];
		
		// reset new tags after re-order
		
		newMiddleScrollView.tag = MIDDLE;
		newBottomScrollView.tag = BOTTOM;
		newTopScrollView.tag = TOP;
		
		// reset the offset for proper viewing
		
		newBottomScrollView.contentOffset = CGPointMake(0, 0);
		newMiddleScrollView.contentOffset = CGPointMake(0, 0);
		newTopScrollView.contentOffset = CGPointMake(320, 0);
		
		// re-add the scroll views in their new order
		
		[verticalScrollView addSubview:newBottomScrollView];
		[newBottomScrollView addSubview:newMiddleScrollView];
		[newMiddleScrollView addSubview:newTopScrollView];
		
	}

	// alert the delegate that a slide has been made

	[self.delegate cardDeck:self didSlideCardAtIndexPath:self.currentCardIndexPath direction:slideDirection];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

