//
//  ViewController.m
//  FightKeaton
//
//  Created by Sohail Khanifar on 2/4/15.
//  Copyright (c) 2015 Sohail Khanifar. All rights reserved.
//

#import "ViewController.h"
#import "FightGame.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *fightButton;
@property (strong,nonatomic) FightGame* game;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view bringSubviewToFront:self.fightButton];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)fightButtonPress:(UIButton *)sender {
    self.game = [[FightGame alloc]init];
    [self nextTurn];
    self.fightButton.enabled = NO;
}

-(void)nextTurn
{
    if (self.game.defendingTeamSoldierCount < 1 || self.game.attackingTeamSoldierCount < 2)
    {
        [self gameOver];
    } else {
        [self.game attackDefendingTeam];
        [self showSoldierCount];
    }
}

-(void)gameOver
{
    self.fightButton.enabled = YES;
    if (self.game.defendingTeamSoldierCount < 1){
        self.redTeamLabel.text = [NSString stringWithFormat:@"Red Attacking Team wins with %ld soldiers remaining!", (long)self.game.attackingTeamSoldierCount];
        self.blueTeamLabel.text = @"Blue Defending Team loses!";
    } else {
        self.blueTeamLabel.text = [NSString stringWithFormat:@"Blue Defending Team wins with %ld soldiers remaining!", (long)self.game.defendingTeamSoldierCount];
        self.redTeamLabel.text = @"Red Attacking Team loses!";
    }
}


-(void)showSoldierCount{
    NSString* defendingSoldiers = [NSString stringWithFormat:@"%ld", (long)self.game.defendingTeamSoldierCount];
    NSString* attackingSoldiers = [NSString stringWithFormat:@"%ld", (long)self.game.attackingTeamSoldierCount];
    [UIView animateWithDuration:.5 animations:^{
        self.redTeamLabel.alpha = 0;
        self.blueTeamLabel.alpha = 0;
    } completion:^(BOOL finished) {
        self.blueTeamLabel.text = [NSString stringWithFormat:@"Defending Team has %@ soldiers", defendingSoldiers];
        self.redTeamLabel.text = [NSString stringWithFormat:@"Attacking Team has %@ soldiers", attackingSoldiers];
        [UIView animateWithDuration:.5 delay:.5 options:UIViewAnimationOptionCurveLinear animations:^{
            self.redTeamLabel.alpha = 1;
            self.blueTeamLabel.alpha = 1;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(showDiceResults) withObject:nil afterDelay:2.0];
        }];
    }];
}

-(void)showDiceResults
 {

    [UIView animateWithDuration:.5 animations:^{
        self.redTeamLabel.alpha = 0;
        self.blueTeamLabel.alpha = 0;
    } completion:^(BOOL finished) {
        self.redTeamLabel.text = [NSString stringWithFormat:@"They rolled:%@", [self.game diceResultsFor:@"attack"]];
        self.blueTeamLabel.text = [NSString stringWithFormat:@"They rolled:%@", [self.game diceResultsFor:@"defense"]];
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.redTeamLabel.alpha = 1;
            self.blueTeamLabel.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:2 animations:^{}completion:^(BOOL finished) {
               [self performSelector:@selector(showLoss) withObject:nil afterDelay:2.0];
            }];
        }];
    }];
}


-(void)showLoss
{
    [UIView animateWithDuration:.5 animations:^{
        self.redTeamLabel.alpha = 0;
        self.blueTeamLabel.alpha = 0;
    } completion:^(BOOL finished) {
        self.redTeamLabel.text = [NSString stringWithFormat:@"They lost %@ soldiers this turn", [self.game lossFor:@"attack"]];
        self.blueTeamLabel.text = [NSString stringWithFormat:@"They lost %@ soldiers this turn", [self.game lossFor:@"defense"]];
        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.redTeamLabel.alpha = 1;
            self.blueTeamLabel.alpha = 1;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(nextTurn) withObject:nil afterDelay:2.0];
        }];
    }];
}



@end
