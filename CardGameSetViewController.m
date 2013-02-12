//
//  CardGameSetViewController.m
//  Matchismo
//
//  Created by Ujwal Manjunath on 2/11/13.
//  Copyright (c) 2013 Ujwal Manjunath. All rights reserved.
//

#import "CardGameSetViewController.h"
#import "PlayingSetCardDeck.h"
#import "cardMatching.h"

@interface CardGameSetViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic)NSUInteger flipCount;
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic,strong) cardMatching *game;
@end

@implementation CardGameSetViewController

-(void)setFlipCount:(NSUInteger)flipCount
{
    _flipCount = flipCount;
    self.flipLabel.text= [NSString stringWithFormat:@"Flips: %d",self.flipCount];
    
}

-(cardMatching *)game
{
    if(!_game)
        _game = [[cardMatching alloc]initWithCardCount:[self cardButtons].count usingDeck:[[PlayingSetCardDeck alloc]init]];
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

-(void) updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:[card contents] forState:UIControlStateSelected];
        [cardButton setTitle:[card contents] forState:UIControlStateSelected|UIControlStateDisabled ];
        
        cardButton.selected = card.isFaceup;
        cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha = (card.isUnPlayable)? 0.3:1.0;
        
    }
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)buttonClick:(UIButton *)sender {
    sender.selected =  ![sender isSelected];
   // [self.game flipCardAtindex:[self.cardButtons indexOfObject:sender] usingmode:nil];
    self.flipCount++;
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








@end
