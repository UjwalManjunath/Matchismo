//
//  cardMatching.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/31/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "cardMatching.h"

@interface cardMatching()
@property(readwrite,nonatomic)int score;
@property (strong,nonatomic) NSMutableArray *cards; //of Card
@end

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1
@implementation cardMatching

-(NSMutableArray *)cards{
    if(!_cards)
        _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(Card *) cardAtIndex:(NSUInteger)index{
    return (index <[self.cards count])? self.cards[index]: nil;
}

-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck{
    self = [super init];
    if(self)
    {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if(card) //if count value is greater than deck count
            self.cards[i]=card;
            else {
                self =nil;
                break;
            }
            
        }
    }
    return self;
}

-(void) flipCardAtindex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(card && !card.isUnPlayable)
    {
        if(!card.isFaceup)
        {
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceup && !otherCard.isUnPlayable){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        card.unPlayable=YES;
                        otherCard.unPlayable=YES;
                        self.score += matchScore * MATCH_BONUS;
                    }else{
                        otherCard.faceUp=NO;
                        self.score-=MISMATCH_PENALTY;
                    }
                    break;
                
                }
            }
              self.score-=FLIP_COST;
        }
    card.faceUp = !card.isFaceup ;
    }
}

@end
