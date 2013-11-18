//
//  KLViewController.m
//  TintColorTest
//
//  Created by Kevin Lundberg on 11/17/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLViewController.h"

@interface KLViewController () <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIView *innerView;

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeColor:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Choose a color:"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Red",@"Green",@"Blue",@"Default",nil];
    [sheet showInView:self.navigationController.view];
}

- (IBAction)changeInnerColor:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Choose a color:"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Red",@"Green",@"Blue",@"Default",nil];
    sheet.tag = 1;
    [sheet showInView:self.navigationController.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIView *view = self.view.window;
    if (actionSheet.tag == 1) {
        view = self.innerView;
    }

    switch (buttonIndex) {
        case 0:
            view.tintColor = [UIColor redColor];
            break;
        case 1:
            view.tintColor = [UIColor greenColor];
            break;
        case 2:
            view.tintColor = [UIColor blueColor];
            break;
        case 3:
            view.tintColor = nil;
            break;
        default:
            break;
    }
}

@end
