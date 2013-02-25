//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/30/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "CardGameViewController.h"

#import "cardMatching.h"

@interface CardGameViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@property (strong, nonatomic) IBOutlet UISegmentedControl *gameMode;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property(nonatomic,strong) cardMatching *game;

@end

@implementation CardGameViewController

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self startCardCount]; //askk model; this is not right way;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self reuseIdentifier] forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card animate:NO];
    
    
    return cell;
}

-(NSString *)reuseIdentifier
{
    return nil; //abstract
}

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)Card animate:(BOOL)animate
{
    //abstract
}

-(cardMatching *)game
{
    if(!_game) _game = [[cardMatching alloc]initWithCardCount:[self startCardCount]
                                                   usingDeck:[self createDeck]];
    return _game;
}

-(Deck *)createDeck
{
    return nil;
    /// abstract
}

-(NSUInteger)startCardCount
{
    return nil; //abstract
}



- (IBAction)gameModeChanged:(id)sender {
    NSLog(@"%d", self.gameMode.selectedSegmentIndex);

    
}



-(void)updateUI    //keep UI in synch with the model
{
    for(UICollectionViewCell *cell in [self.cardCollectionView visibleCells])
    {
        NSIndexPath *index = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:index.item];
        [self updateCell:cell usingCard:card animate:YES];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *index = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if(index)
    {
  
    [self.game flipCardAtindex:index.item usingmode:self.tabBarController.selectedIndex];
    self.descLabel.text = [self getDescription];
    [self updateUI];
    
    }
    
}
-(NSString *)getDescription
{
    NSString *description;
    if([self.game.status isEqualToString:@"Match"])
    {
        description =[NSString stringWithFormat:@"Matched "];
        description =[description stringByAppendingString:[self getCardContentsFromArray:self.game.selectedCards] ] ;
        description = [description stringByAppendingString:[NSString stringWithFormat:@" for %d points",self.game.deltaScore]];
        self.game.selectedCards =nil;
    }else if ([self.game.status isEqualToString:@"Mismatch"])
    {
        description = [self getCardContentsFromArray:self.game.misMatchCards];
        description = [description stringByAppendingString:@" Dont Match"];
        description = [description stringByAppendingString:[NSString stringWithFormat:@" -%d points",self.game.deltaScore]];
        self.game.misMatchCards=nil;
    }
    else if([self.game.status isEqualToString:@"flip"])
    {
        description = [NSString stringWithFormat:@"You fliped %@ -1 point",[self getCardContentsFromArray:self.game.selectedCards]];
      
    }else
    {
        description = @"You unflipped a card";
    }
    
    return description ;
}
- (IBAction)dealAgain
{
    self.gameMode.userInteractionEnabled=YES;
    self.gameMode.alpha=1;
    self.game =nil;
    [self game];
    [self updateUI];
    self.flipCount =0;
    self.descLabel.text =@"New Cards";
    
}


-(NSString *)getCardContentsFromArray:(NSArray *)arrayOfCards{
    NSMutableArray *cards = [[NSMutableArray alloc]init];
    for( Card *card in arrayOfCards)
    {
        [cards addObject:card.contents];
    }
    return [cards componentsJoinedByString:@" & "];
}

@end
