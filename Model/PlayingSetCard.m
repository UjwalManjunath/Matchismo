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
    int score=0;
    
    return score;
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
    return @[@"diamond",@"squiggle",@"oval"];
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
