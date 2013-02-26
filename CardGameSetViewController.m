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
    return 12;
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
        
           [self removeMatchedcards];
       }
   }
    
}

-(NSString * )reuseIdentifier
{
    return @"SetCard";
}

-(void)removeMatchedcards
{
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc]init];
    NSMutableArray *indexPaths = [[NSMutableArray alloc]init];
    for(UICollectionViewCell *cell in [self.cardCollectionView visibleCells])
    {
        NSIndexPath *index = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:index.item];
        
        if(card.isFaceup && card.isUnPlayable)
        {
            [indexSet addIndex:[self.game getIndexOfCard:card]];
            [indexPaths addObject:index];
            
        }
    }
    if([indexSet count])
    {
        [self.game deleteCardAtIndexes:indexSet];
        [self.cardCollectionView deleteItemsAtIndexPaths:indexPaths];
    }
    
    
}
- (IBAction)addCards
{
    NSMutableArray *indexPaths = [[NSMutableArray alloc]init];
    [self.game addCardsFromDeck:[self createDeck]];
    NSUInteger count=[self.cardCollectionView numberOfItemsInSection:0] ;
    for(; count<[self.game noIfCardsInPlay];count++)
    {
        [indexPaths addObject:[NSIndexPath indexPathForItem:count inSection:0]];
        
        
    }
    [self.cardCollectionView insertItemsAtIndexPaths:indexPaths];
    [self.cardCollectionView scrollToItemAtIndexPath:[indexPaths lastObject] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES
     ];    //[self.cardCollectionView reloadItemsAtIndexPaths:indexPaths];
   // [self.cardCollectionView insert
    
    
}

@end
