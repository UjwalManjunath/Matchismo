//
//  PlayingSetCard.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 2/11/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "PlayingSetCard.h"

@implementation PlayingSetCard


-(int)match:(NSArray *)otherCards
{
    int equalNumberCount = 0,unEqualNumberCount=0;
    int equalColorCount=0,unEqualColorCount=0;
    int equalShadingCount=0, unEqualShadingCount=0;
    int equalSymbolCount=0, unEqualSymbolCount=0;
    int score=0;
    for(PlayingSetCard *card in otherCards)
    {
       if(self.number == card.number)
       {
           equalNumberCount++;
        
       }else
       {
           unEqualNumberCount++;
          
       }
        
        if([self.color isEqualToString:card.color])
        {
            equalColorCount++;
        }
        else{
            unEqualColorCount++;
        }
        if([self.shading isEqualToString:card.shading])
        {
            equalShadingCount++;
        }
        else{
           unEqualShadingCount++;
        }
        if([self.symbol isEqualToString:card.symbol])
        {
            equalSymbolCount++;
            
        }else{
            unEqualSymbolCount++;
        }
        
    }
    int count = [otherCards count];
    if((equalSymbolCount == count || unEqualSymbolCount ==count ) && (equalShadingCount ==count || unEqualShadingCount==count) && (equalNumberCount ==count || unEqualNumberCount ==count) &&(unEqualColorCount ==count|| equalColorCount==count) )
        score=1;
    return score;
}




-(NSString *)contents{
  
    //@[] is [NSArray alloc]initwithObjects: ...
    NSString *cardWithSymbols = [self.symbol stringByPaddingToLength:self.number withString:self.symbol startingAtIndex:0];
  
    
    
        
    
   
 
    return cardWithSymbols;
    
    
 //   return [rankString[self.rank] stringByAppendingString:self.suit];
}

-(NSString *)symbol{
    return _symbol ? _symbol : @"?";
}

+(NSArray *)numbers
{
    return @[@"?",@"1",@"2",@"3"];
}

+(NSArray *)validSymbol
{
    return @[@"▲",@"●",@"■"];
}

+(NSArray *)validColor
{
    return @[@"red",@"green",@"purple"];
}

+(NSArray *)validShading
{
    return  @[@"solid",@"striped",@"open"];
    
}

+(NSUInteger) maxNumber
{
    return [[self numbers]count]-1;
}

-(void)setNumber:(NSUInteger)number
{
    if(number <=[PlayingSetCard maxNumber])
        _number=number;
}


@end
