//
//  CKViewController.m
//  CKCountdownButton
//
//  Created by Quanlong He on 08/02/2014.
//  Copyright (c) 2014 Quanlong He. All rights reserved.
//

#import "CKViewController.h"

@interface CKViewController ()

@property (nonatomic, strong) IBOutlet UIButton *secondButton;
@end

@implementation CKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.secondButton addTarget:self
                          action:@selector(gotoSecondView:)
                forControlEvents:UIControlEventTouchUpInside];
}

- (void)dealloc {
    NSLog(@"Dealloc for CKVC.");
}

- (IBAction)gotoSecondView:(id)sender {
    [self performSegueWithIdentifier:@"GotoSecond" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
