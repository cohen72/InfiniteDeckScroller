//
//  ViewController.m
//  SCROLL
//
//  Created by Wibbitz on 12/16/12.
//  Copyright (c) 2012 Wibbitz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) CardDeckViewController *cardDeck;
@property (nonatomic, strong) NSArray *cardsViewsArray;

@end



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	
	self.cardsViewsArray = [NSArray arrayWithObjects:[self labelWithText:@"0" withBgColor:[UIColor redColor]],
							[self labelWithText:@"1" withBgColor:[UIColor orangeColor]],
							[self labelWithText:@"2" withBgColor:[UIColor yellowColor]],
							[self labelWithText:@"3" withBgColor:[UIColor greenColor]],
							[self labelWithText:@"4" withBgColor:[UIColor blueColor]],
							[self labelWithText:@"5" withBgColor:[UIColor purpleColor]],
							[self labelWithText:@"6" withBgColor:[UIColor brownColor]],
							[self labelWithText:@"7" withBgColor:[UIColor lightGrayColor]],
							[self labelWithText:@"8" withBgColor:[UIColor grayColor]], nil];

	
	self.cardDeck = [[CardDeckViewController alloc] init];
	self.cardDeck.delegate = self;
	self.cardDeck.view.frame = self.view.bounds;
	
	[self.view addSubview:self.cardDeck.view];
	
	
	
	[self.cardDeck reloadCardDeck];
	
}


-(UIView *)cardDeck:(CardDeckViewController *)cardDeck cardViewForIndexPath:(NSIndexPath *)cardIndexPath{
	return [self.cardsViewsArray objectAtIndex:cardIndexPath.row];
}

-(NSInteger)cardDeck:(CardDeckViewController *)cardDeck numberOfCardsInSection:(NSInteger)section{
	return [self.cardsViewsArray count];
}

-(NSInteger)numberOfSectionsInDeck:(CardDeckViewController *)cardDeck{
	return 1;
}

-(void)cardDeck:(CardDeckViewController *)cardDeck didSlideCardAtIndexPath:(NSIndexPath *)indexPath direction:(CardDeckSlideDirection)slideDirection{
	
}


- (UILabel*)labelWithText:(NSString*)text withBgColor:(UIColor*)color{
	UILabel *lbl = [[UILabel alloc] initWithFrame:self.view.bounds];
	lbl.textAlignment = NSTextAlignmentCenter;
	lbl.backgroundColor = color;
	lbl.text = text;
	return lbl;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
