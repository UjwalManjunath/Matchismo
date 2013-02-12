//
//  PlayingSetCard.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 2/11/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "PlayingSetCard.h"

@implementation PlayingSetCard

#define ALLEQUAL 3
#define ALLNOTEQUAL 1
-(int)match:(NSArray *)otherCards
{
    
    int score=0;
    
    NSMutableSet *numberSet = [[NSMutableSet alloc]init];
    NSMutableSet *colorSet = [[NSMutableSet alloc]init];
    NSMutableSet *shadingSet =[[NSMutableSet alloc]init];
    NSMutableSet *symbolSet = [[NSMutableSet alloc]init];
    
    [numberSet addObject:[NSNumber numberWithUnsignedInt:self.number]];
    [colorSet addObject:self.color];
    [shadingSet addObject:self.shading];
    [symbolSet addObject:self.symbol];
    
    for(PlayingSetCard *card in otherCards)
    {
        [numberSet addObject:[NSNumber numberWithUnsignedInt:card.number]];
        [colorSet addObject:card.color];
        [shadingSet addObject:card.shading];
        [symbolSet addObject:card.symbol];
        
    }
    
    if( ([numberSet count ] == ALLEQUAL || [numberSet count ]== ALLNOTEQUAL) &&
       ([shadingSet count]==ALLEQUAL ||[shadingSet count]== ALLNOTEQUAL) &&
       ([colorSet count] == ALLEQUAL ||[colorSet count] == ALLNOTEQUAL  ) &&
       ([symbolSet count]==ALLEQUAL ||[symbolSet count]== ALLNOTEQUAL))
        score = 4;
    
 
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
