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

-(NSString *) flipCardAtindex:(NSUInteger)index usingmode:(NSUInteger)gameMode
{
   
    NSMutableArray *playingCards = [[NSMutableArray alloc]init];
    NSString *description;
    Card *card = [self cardAtIndex:index];
    if(card && !card.isUnPlayable)
    {
        if(!card.isFaceup)
        {
            description = [NSString stringWithFormat:@"You Flipped %@, %d point penalty",card.contents,FLIP_COST];
            for(Card *otherCard in self.cards){
             
            if(otherCard.isFaceup && !otherCard.isUnPlayable){
                        [playingCards addObject:otherCard];
            
                //if([playingCards count] ==gameMode+1){
                      int matchScore = [card match:[playingCards copy]];
                    if(matchScore){
                        if([playingCards count] ==gameMode+1){
                            card.unPlayable =YES;
                            for(Card *cardsPlayed in playingCards){
                                cardsPlayed.UnPlayable=YES;
                            }
                            self.score+=matchScore*MATCH_BONUS;
                            description=[NSString stringWithFormat:@"Matched %@,%@, +%d points",card.contents,[cardMatching getCardContentsFromArray:[playingCards copy]],matchScore*MATCH_BONUS];
                        }else continue;
                    } else {
                        for(Card *cardPlayed in playingCards){
                            cardPlayed.unPlayable=NO;
                            cardPlayed.faceUp=NO;
                        }
                        self.score-=MISMATCH_PENALTY;
                        description = [NSString stringWithFormat:@"%@ , %@ don't match!! %d point penalty",card.contents,[cardMatching getCardContentsFromArray:playingCards],MISMATCH_PENALTY];
                    }
                    
                 
                }
               
            }
                   self.score-=FLIP_COST;
           
        }else {
            description = @"You UnFlipped a Card";
        }
        card.faceUp = !card.isFaceup ;
    }
    return description;
}

+(NSString *)getCardContentsFromArray:(NSArray *)arrayOfCards{
    NSMutableArray *cardContents = [[NSMutableArray alloc]init];
    for(Card *card in arrayOfCards)
    {
        [cardContents addObject:card.contents];
    }
    return [cardContents componentsJoinedByString:@","];
}

    
                
                
                
              
                        
             
        
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
             
        




              
            
        
@end
