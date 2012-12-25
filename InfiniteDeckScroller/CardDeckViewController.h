//
//  CardDeckViewController.h
//  InfiniteDeckScroller
//
//  Created by Wibbitz on 12/25/12.
//  Copyright (c) 2012 Cohen72. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CardDeckSlideDirectionTop = 0,
    CardDeckSlideDirectionLeft,
	CardDeckSlideDirectionBottom,
    CardDeckSlideDirectionRight
} CardDeckSlideDirection;


@protocol CardDeckDelegate;
@protocol CardDeckDataSource;

@interface CardDeckViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) id <CardDeckDelegate, CardDeckDataSource> delegate;

- (void)reloadCardDeck;

@end

#pragma mark CardDeckDelegate

@protocol CardDeckDelegate <NSObject>

-(void)		cardDeck:(CardDeckViewController *)cardDeck didSlideCardAtIndexPath:(NSIndexPath *)indexPath direction:(CardDeckSlideDirection)slideDirection;

@end


#pragma mark CardDeckDatasource

@protocol CardDeckDataSource <NSObject>

@required
-(UIView *)	cardDeck:(CardDeckViewController *)cardDeck cardViewForIndexPath:(NSIndexPath*)cardIndexPath;
-(NSInteger)numberOfSectionsInDeck:(CardDeckViewController *)cardDeck;
-(NSInteger)cardDeck:(CardDeckViewController *)cardDeck numberOfCardsInSection:(NSInteger)section;

@end
