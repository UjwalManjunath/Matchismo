//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/30/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "cardMatching.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property(nonatomic,strong) cardMatching *game;
@end

@implementation CardGameViewController

-(cardMatching *)game
{
    if(_game) _game = [[cardMatching alloc]initWithCardCount:[self.cardButtons count]
                                                   usingDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}



-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons=cardButtons;
    [self updateUI];

    
}

-(void)updateUI
{
    
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtindex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
    self.flipCount++;
    
}

@end
