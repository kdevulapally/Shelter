//
//  ViewController.m
//  Shelter
//
//  Created by KArthik KAshyap on 7/17/14.
//  Copyright (c) 2014 SolsticExpressDay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray *images;

@property (weak, nonatomic) IBOutlet JBKenBurnsView *screenSaver;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.images = @[[UIImage imageNamed:@"image1.jpg"], [UIImage imageNamed:@"image2.jpg"], [UIImage imageNamed:@"image3.jpg"], [UIImage imageNamed:@"image4.jpg"], [UIImage imageNamed:@"image5.jpg"], [UIImage imageNamed:@"image6.jpg"]];
    [self.screenSaver.layer setBorderWidth:1];
    [self.screenSaver.layer setBorderColor:[UIColor blackColor].CGColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.screenSaver animateWithImages:self.images transitionDuration:5.0 initialDelay:0 loop:YES isLandscape:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
