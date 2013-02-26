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
@property(readwrite,nonatomic)int deltaScore;
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

-(void )removeCardsAtIndexes:(NSIndexSet *)indexes
{
   
    
}

-(id)initWithCardCount:(NSUInteger)count
usingDeck:(Deck *)deck 

{
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

-(NSArray *)selectedCards
{
    if(!_selectedCards) _selectedCards = [[NSArray alloc]init];
    return _selectedCards;
}
-(NSArray *)misMatchCards
{
    if(!_misMatchCards) _misMatchCards = [[NSArray alloc]init];
    return _misMatchCards;
}
-(void) flipCardAtindex:(NSUInteger)index usingmode:(NSUInteger)gameMode
{
    NSMutableArray *selectCards= [[NSMutableArray alloc]initWithArray:self.selectedCards];
    NSMutableArray *playingCards = [[NSMutableArray alloc]init];
    Card *card = [self cardAtIndex:index];
    if(card && !card.isUnPlayable)
    {
        if(!card.isFaceup){
            [selectCards addObject:card];
            self.status = @"flip";
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceup && !otherCard.isUnPlayable){
                    [playingCards addObject:otherCard];
                    if([playingCards count] ==gameMode+1){
                        int matchScore = [card match:[playingCards copy]];
                        if(matchScore){
                            card.unPlayable =YES;
                            for(Card *cardsPlayed in playingCards){
                                cardsPlayed.UnPlayable=YES;
                                }
                            self.deltaScore = matchScore *MATCH_BONUS;
                            self.score+=self.deltaScore;
                            self.status = @"Match";
                            }
                        else
                            {
                            self.misMatchCards = [[NSArray alloc]initWithArray:selectCards];
                            for(Card *cardPlayed in playingCards){
                                cardPlayed.unPlayable=NO;
                                cardPlayed.faceUp=NO;
                                [selectCards removeObject:cardPlayed];
                                }
                            self.deltaScore = MISMATCH_PENALTY;
                            self.score-=self.deltaScore;
                            self.status=@"Mismatch";
                            }
                        }else continue;
                    }
            
                }
            self.score-=FLIP_COST;
            }else {
            [selectCards removeObject:card];
            self.status= @"unflip";
           }
        card.faceUp = !card.isFaceup ;
    }
    self.selectedCards = [selectCards copy];
}

-(void)deleteCardAtIndexes:(NSIndexSet *)indexSet
{
    [self.cards removeObjectsAtIndexes:indexSet ];
}

-(NSUInteger)getIndexOfCard:(Card *)card
{
    return [self.cards indexOfObject:card];
}

-(NSUInteger)noIfCardsInPlay
{
    return [self.cards count];
}

-(void) addCardsFromDeck:(Deck *)deck
{
    for (int i=0; i<3; i++) {
        Card *card = [deck drawRandomCard];
        if(card) //if count value is greater than deck count
            [self.cards addObject:card];
        else {
          
            break;
        }
        
    }
    
}



@end
