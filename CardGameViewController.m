//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 1/30/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "cardMatching.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (strong, nonatomic) IBOutlet UISegmentedControl *gameMode;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property(nonatomic,strong) cardMatching *game;

@end

@implementation CardGameViewController

-(cardMatching *)game
{
    if(!_game) _game = [[cardMatching alloc]initWithCardCount:[self.cardButtons count]
                                                   usingDeck:[[PlayingCardDeck alloc]init]];
    return _game;
}




- (IBAction)gameModeChanged:(id)sender {
    NSLog(@"%d", self.gameMode.selectedSegmentIndex);

    
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons=cardButtons;
    [self updateUI];

    
}

-(void)updateUI    //keep UI in synch with the model
{
    for(UIButton *cardButton in self.cardButtons)
    {
       // UIImage *noimage ;
        UIImage *cardBackImage = [UIImage imageNamed:@"cardimage.jpg"];
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
         
        cardButton.imageEdgeInsets = UIEdgeInsetsMake(3, 2, 3, 2);
       [cardButton setTitle:card.contents forState:UIControlStateSelected];
      
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];

        cardButton.selected = card.isFaceup;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = (card.isUnPlayable ? 0.3 : 1.0 );
        if(cardButton.selected)
            cardBackImage = nil;
            [cardButton setImage:cardBackImage forState:UIControlStateNormal ];
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    self.gameMode.userInteractionEnabled=NO;
    self.gameMode.alpha=0.3;
    //self.descLabel.text =
    [self.game flipCardAtindex:[self.cardButtons indexOfObject:sender]usingmode:self.tabBarController.selectedIndex];
    [self updateUI];
    self.flipCount++;
    
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

@end
