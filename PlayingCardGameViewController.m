//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 2/25/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardCollectionViewCell.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}
-(NSUInteger) startCardCount
{
    return 20;
}

-(NSString *)reuseIdentifier
{
    return @"PlayingCard";
}

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)Card animate:(BOOL)animate
{
    if([cell isKindOfClass:[PlayingCardCollectionViewCell class]])
    {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if([Card isKindOfClass:[PlayingCard class]]){
            PlayingCard *playingCard = (PlayingCard *)Card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            if(animate && playingCardView.faceUp!= playingCard.isFaceup)
            {
                [UIView transitionWithView:playingCardView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                      playingCardView.faceUp = playingCard.isFaceup;
                }completion:NULL];
            }
            else
            {
                  playingCardView.faceUp = playingCard.isFaceup;
            }
          
            playingCardView.alpha = playingCard.isUnPlayable?0.3:1.0;
            
            
        }
    }
}

@end
