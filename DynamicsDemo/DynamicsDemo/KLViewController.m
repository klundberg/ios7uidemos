//
//  KLViewController.m
//  DynamicsDemo
//
//  Created by Kevin Lundberg on 11/15/13.
//  Copyright (c) 2013 Lundbergsoft. All rights reserved.
//

#import "KLViewController.h"

@interface KLViewController ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collision;
@property (nonatomic, strong) NSArray *views;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *beginButtonItem;

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    [self addViewsAndBehaviors];

    [self addPanRecognizer];
}

- (void)addPanRecognizer
{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)gesture
{
//    if (gesture.state == UIGestureRecognizerStateBegan) {
//        CGPoint point = [gesture locationInView:self.view];
//        __block UIView *view;
//        [self.views enumerateObjectsUsingBlock:^(UIView *shape, NSUInteger idx, BOOL *stop) {
//            CGRect frame = shape.frame;
//            if
//        }];
//    }
}

- (void)addShape
{
	// Do any additional setup after loading the view, typically from a nib.

    NSInteger size = arc4random() % 50 + 25;
    NSInteger pos = arc4random() % (int)(self.view.bounds.size.width - size);
    CGRect frame = CGRectMake(pos, 0, size, size);

    UIView* square = [[UIView alloc] initWithFrame:frame];

    NSArray *colors = @[[UIColor redColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor yellowColor],
                        [UIColor cyanColor],
                        [UIColor magentaColor]];

    square.backgroundColor = colors[arc4random() % colors.count];
    [self.view addSubview:square];

    self.views = [self.views arrayByAddingObject:square];

    [self.gravity addItem:square];
    [self.collision addItem:square];

    UIDynamicItemBehavior *behavior = [[UIDynamicItemBehavior alloc] initWithItems:@[square]];
    behavior.elasticity = (float)rand()/(float)(RAND_MAX);
//    behavior.elasticity = 1.0;

    [self.animator addBehavior:behavior];

}

- (void)addViewsAndBehaviors
{
    UIView* barrier = [[UIView alloc] initWithFrame:CGRectMake(20, 200, 130, 20)];
    barrier.backgroundColor = [UIColor grayColor];
    barrier.transform = CGAffineTransformMakeRotation(M_PI_4);
    [self.view addSubview:barrier];

    self.views = @[barrier];

    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[]];
//    [self.gravity setGravityDirection:CGVectorMake(-1.0, 1.0)];
//    [self.gravity setMagnitude:10];


    self.collision = [[UICollisionBehavior alloc] initWithItems:@[]];
    UIView *toolbar = self.navigationController.toolbar;
    [self.collision setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(-200, 0, toolbar.frame.size.height, 0)];

    [self addCollisionBoundaryForItem:barrier toBehavior:self.collision withIdentifier:@"barrier"];


    [self.animator addBehavior:self.gravity];
    [self.animator addBehavior:self.collision];
}

- (void)addCollisionBoundaryForItem:(UIView *)item toBehavior:(UICollisionBehavior *)behavior withIdentifier:(NSString *)identifier
{
//    cgrecta
    CGRect frame = [self.view convertRect:item.bounds fromView:item];
    CGPoint topleft = CGPointApplyAffineTransform(frame.origin, item.transform);
    CGPoint topright = CGPointApplyAffineTransform(CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame)), item.transform);
    CGPoint bottomleft = CGPointApplyAffineTransform(CGPointMake(CGRectGetMinX(frame), CGRectGetMaxY(frame)), item.transform);
    CGPoint bottomRight = CGPointApplyAffineTransform(CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame)), item.transform);

    [behavior addBoundaryWithIdentifier:[NSString stringWithFormat:@"%@-top",identifier] fromPoint:topleft toPoint:topright];
    [behavior addBoundaryWithIdentifier:[NSString stringWithFormat:@"%@-right",identifier] fromPoint:topright toPoint:bottomRight];
    [behavior addBoundaryWithIdentifier:[NSString stringWithFormat:@"%@-bottom",identifier] fromPoint:bottomRight toPoint:bottomleft];
    [behavior addBoundaryWithIdentifier:[NSString stringWithFormat:@"%@-left",identifier] fromPoint:bottomleft toPoint:topleft];
}

- (IBAction)beginButtonTapped:(id)sender {
    [self addShape];
}

- (IBAction)resetButtonTapped:(id)sender {
    [self.animator removeAllBehaviors];

    [self.views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    [self addViewsAndBehaviors];
}

@end
