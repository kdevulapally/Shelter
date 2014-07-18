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
@property (strong, nonatomic) NSArray *storytitlesArray;
@property (strong, nonatomic) NSArray *storyBodyArray;
@property (weak, nonatomic) IBOutlet UIView *storyview;
@property (weak, nonatomic) IBOutlet UITextView *storyBody;
@property (weak, nonatomic) IBOutlet UILabel *storyTitle;
@property (weak, nonatomic) IBOutlet UIView *qrView;
@property (weak, nonatomic) IBOutlet JBKenBurnsView *screenSaver;
@property (assign, nonatomic) int count;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.images = @[[UIImage imageNamed:@"image2.jpg"], [UIImage imageNamed:@"image7.jpg"], [UIImage imageNamed:@"image4.jpg"], [UIImage imageNamed:@"image5.jpg"], [UIImage imageNamed:@"image6.jpg"]];
    [self.screenSaver.layer setBorderWidth:1];
    [self.screenSaver.layer setBorderColor:[UIColor blackColor].CGColor];
    self.storytitlesArray = @[@"Test", @"Hello"];
    self.storyBodyArray = @[@"testjfaljsdfjalkjsdfja jlas df; alksjdf l jlasj dfl", @"Hello asdjflkajsl;dj  laksjdf lajsd f lajsdlkfj asjl"];
    self.storyTitle.text = [self.storytitlesArray objectAtIndex:0];
    self.storyBody.text = [self.storyBodyArray objectAtIndex:0];
    self.count = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                   selector:@selector(updateStoryText)
                                   userInfo:nil
                                    repeats:YES];
    
    [self.screenSaver animateWithImages:self.images transitionDuration:5.0 initialDelay:0 loop:YES isLandscape:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tipMeButtonTapped:(id)sender {
    [UIView animateWithDuration:0.4 animations:^{
        [self.qrView setAlpha:1.0];
    }];
}

- (IBAction)qrViewCloseButton:(id)sender {
    [UIView animateWithDuration:0.4 animations:^{
        [self.qrView setAlpha:0.0];
    }];
}

- (void)updateStoryText {
        [UIView animateWithDuration:3.0 delay:0.0 options:UIViewAnimationOptionCurveLinear  animations:^{
            self.storyview.alpha = 0.0;
//            self.count++;
//            NSLog(@"%d", self.count);
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:1.0 animations:^{
                    self.storyview.alpha = 1.0;
//                    NSLog(@"%d", self.count);
//                    self.storyTitle.text = [self.storytitlesArray objectAtIndex:(self.count % 2)];
//                    self.storyBody.text = [self.storyBodyArray objectAtIndex:(self.count %2)];
                } completion:^(BOOL finished) {
                    
                }];
            }
        }];
    
}

@end
