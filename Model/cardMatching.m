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

-(NSArray *)selectedCards
{
    if(!_selectedCards) _selectedCards = [[NSArray alloc]init];
    return _selectedCards;
}
-(void) flipCardAtindex:(NSUInteger)index usingmode:(NSUInteger)gameMode
{
    NSMutableArray *selectCards= [[NSMutableArray alloc]initWithArray:self.selectedCards];
    NSMutableArray *playingCards = [[NSMutableArray alloc]init];
    NSString *description;
    Card *card = [self cardAtIndex:index];
    if(card && !card.isUnPlayable)
    {
        if(!card.isFaceup)
        {
            [selectCards addObject:card];
            
            description = [NSString stringWithFormat:@"You Flipped %@, %d point penalty",card.contents,FLIP_COST];
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
                          //  description=[NSString stringWithFormat:@"Matched %@,%@, +%d points",card.contents,[cardMatching getCardContentsFromArray:[playingCards copy]],matchScore*MATCH_BONUS];
                        self.status = @"Match";
                       
                    } else {
                        for(Card *cardPlayed in playingCards){
                            cardPlayed.unPlayable=NO;
                            cardPlayed.faceUp=NO;
                            [selectCards removeObject:cardPlayed];
                        }
                        self.deltaScore = MISMATCH_PENALTY;
                        self.score-=self.deltaScore;
                     //   description = [NSString stringWithFormat:@"%@ , %@ don't match!! -%d points ",card.contents,[cardMatching getCardContentsFromArray:[playingCards copy]],MISMATCH_PENALTY];
                        self.status=@"Mismatch";
                    }
                     }else continue;
                 
            }
            
               
            }
                   self.score-=FLIP_COST;
           
        }else {
            [selectCards removeObject:card];
            self.status= @"flip";
            description = @"You UnFlipped a Card";
        }
        card.faceUp = !card.isFaceup ;
    }
    self.selectedCards = [selectCards copy];

}




    
    
    
                
              
                        
             
        
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
             
        




              
            
        
@end
