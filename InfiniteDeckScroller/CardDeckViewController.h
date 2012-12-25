//
//  CardDeckViewController.h
//  InfiniteDeckScroller
//
//  Created by Wibbitz on 12/25/12.
//  Copyright (c) 2012 Cohen72. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardDeckDelegate;
@protocol CardDeckDataSource;

@interface CardDeckViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) id <CardDeckDelegate, CardDeckDataSource> delegate;

@end

@protocol CardDeckDelegate <NSObject>

@end

@protocol CardDeckDataSource <NSObject>

-(UIView *)		cardDeck:(CardDeckViewController *)cardDeck cardViewForIndex:(int)cardIndex;
-(NSInteger)	numberOfCardsInDeck:(CardDeckViewController *)cardDeck;


@end
