//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/30/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit=_suit;

-(int)match:(NSArray *)otherCards
{
    int suitCount=0,rankCount=0;
    int score =0;
           NSMutableArray *cardList = [otherCards copy];
            for( PlayingCard *otherPlayingCard in cardList){
                if([self.suit isEqualToString:otherPlayingCard.suit]){
                    suitCount++;
                 
                }
               else if(self.rank == otherPlayingCard.rank ){
                   rankCount++;
                }
             
            }
              
            
            
        if(suitCount == [cardList count] || rankCount == [cardList count])
        {
         score = suitCount * 1 + rankCount * 4;   
        }
    
    return score;
}

-(NSString *)suit{
    return _suit ? _suit : @"?";
}

+(NSArray *)validSuits{
    return @[@"♠",@"♣",@"♦",@"♥"];
}

-(void) setSuit:(NSString *)suit{
    if([[PlayingCard validSuits] containsObject:suit])
        _suit=suit;
        
}

-(NSString *)contents{
    NSArray *rankString = [PlayingCard rankStrings];
    //@[] is [NSArray alloc]initwithObjects: ...
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

+(NSArray *)rankStrings{
    return  @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank{
    return [self rankStrings].count-1 ;
}

-(void)setRank:(NSUInteger)rank
{
    if(rank <=[PlayingCard maxRank])
        _rank=rank;
}
@end

