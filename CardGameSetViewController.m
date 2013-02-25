//
//  CardGameSetViewController.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 2/11/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "CardGameSetViewController.h"
#import "PlayingSetCardDeck.h"
#import "PlayingSetCard.h"
#import "SetCardCollectionViewCell.h"


@interface CardGameSetViewController ()

@end

@implementation CardGameSetViewController

-(Deck *)createDeck
{
    return [[PlayingSetCardDeck alloc]init];
}

-(NSUInteger)startCardCount
{
    return 20;
}

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)Card animate:(BOOL)animate
{
   if([cell isKindOfClass:[SetCardCollectionViewCell class]])
   {
       SetCardView *setCardView =  ((SetCardCollectionViewCell *)cell).setCardView;
       if([Card isKindOfClass:[PlayingSetCard class]]){
           PlayingSetCard *setCard = (PlayingSetCard *)Card;
           setCardView.symbol = setCard.symbol;
           setCardView.number= setCard.number;
           setCardView.color = setCard.color;
           setCardView.shading = setCard.shading;
           setCardView.selected = setCard.isFaceup;
        
           setCardView.alpha = setCard.isUnPlayable?0.3:1.0;
       }
   }
    
}

-(NSString * )reuseIdentifier
{
    return @"SetCard";
}


@end
