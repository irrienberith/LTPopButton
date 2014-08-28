//
//  ViewController.m
//  LTPopButton
//
//  Created by ltebean on 14-8-28.
//  Copyright (c) 2014年 ltebean. All rights reserved.
//

#import "ViewController.h"
#import "LTPopButton.h"

@interface ViewController ()
@property(nonatomic,strong) LTPopButton* button;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.button = [[LTPopButton alloc]initWithFrame:CGRectMake(100, 100, 36, 30)];
    self.button.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)/2);
    [self.view addSubview:self.button];
}

- (IBAction)changeButtonType:(UIButton *)sender {
    [self.button animateToType:sender.tag];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
