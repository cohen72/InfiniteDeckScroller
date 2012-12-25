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
	
	self.cardDeck = [[CardDeckViewController alloc] init];
	self.cardDeck.delegate = self;
	
	
	self.cardsViewsArray = [NSArray arrayWithObjects:[self labelWithText:@"0" withBgColor:[UIColor redColor]],
							[self labelWithText:@"1" withBgColor:[UIColor orangeColor]],
							[self labelWithText:@"2" withBgColor:[UIColor yellowColor]],
							[self labelWithText:@"3" withBgColor:[UIColor greenColor]],
							[self labelWithText:@"4" withBgColor:[UIColor blueColor]],
							[self labelWithText:@"5" withBgColor:[UIColor purpleColor]],
							[self labelWithText:@"6" withBgColor:[UIColor brownColor]],
							[self labelWithText:@"7" withBgColor:[UIColor lightGrayColor]],
							[self labelWithText:@"8" withBgColor:[UIColor grayColor]], nil];

	self.cardDeck.view.frame = self.view.bounds;
	
	[self.view addSubview:self.cardDeck.view];
	
}


-(UIView *)cardDeck:(CardDeckViewController *)cardDeck cardViewForIndex:(int)cardIndex{
	return [self.cardsViewsArray objectAtIndex:cardIndex];
}

-(NSInteger)numberOfCardsInDeck:(CardDeckViewController *)cardDeck{
	return [self.cardsViewsArray count];
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
