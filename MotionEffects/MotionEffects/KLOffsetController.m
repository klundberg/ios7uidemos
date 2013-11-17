//
//  KLViewController.m
//  MotionEffects
//
//  Created by Kevin Lundberg on 11/16/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLOffsetController.h"

@interface KLOffsetController ()
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view1;


@end

@implementation KLOffsetController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view1.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.view2.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.view3.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.view4.layer.shadowColor = [[UIColor blackColor] CGColor];

    self.view1.layer.shadowOpacity = 0.5;
    self.view2.layer.shadowOpacity = 0.5;
    self.view3.layer.shadowOpacity = 0.5;
    self.view4.layer.shadowOpacity = 0.5;

    [self.view1 addMotionEffect:[self effectsForView:1]];
    [self.view2 addMotionEffect:[self effectsForView:2]];
    [self.view3 addMotionEffect:[self effectsForView:3]];
    [self.view4 addMotionEffect:[self effectsForView:4]];
}

- (UIMotionEffect *)effectsForView:(NSInteger)viewnum
{
    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];

    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    UIInterpolatingMotionEffect *horizEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];

    UIInterpolatingMotionEffect *shadowEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"layer.shadowOffset" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];

    shadowEffect.minimumRelativeValue = [NSValue valueWithCGSize:CGSizeMake(-10, 5)];
    shadowEffect.maximumRelativeValue = [NSValue valueWithCGSize:CGSizeMake(10, 5)];

    NSInteger maxrange = 40 * viewnum;

    verticalEffect.minimumRelativeValue = horizEffect.minimumRelativeValue = @(-maxrange);
    verticalEffect.maximumRelativeValue = horizEffect.maximumRelativeValue = @(maxrange);

    group.motionEffects = @[horizEffect, verticalEffect, shadowEffect];

    return group;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
