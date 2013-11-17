//
//  KLTransformViewController.m
//  MotionEffects
//
//  Created by Kevin Lundberg on 11/17/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLTransformViewController.h"

@interface KLTransformViewController ()
@property (weak, nonatomic) IBOutlet UIView *transformView;

@end

@implementation KLTransformViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"layer.transform" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];

    CATransform3D perpectiveTransform = CATransform3DIdentity;
    perpectiveTransform.m34 = -1.0 / 800;

    horizontalEffect.minimumRelativeValue = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeRotation(M_PI_4, 0, 1, 0), perpectiveTransform)];
    horizontalEffect.maximumRelativeValue = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeRotation(-M_PI_4, 0, 1, 0), perpectiveTransform)];

    [self.transformView addMotionEffect:horizontalEffect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
