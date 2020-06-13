//
//  PageFourVC.m
//  LEARNIOS
//
//  Created by Ranajit Chandra on 11/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "PageFourVC.h"
#import "PageFiveVC.h"

@interface PageFourVC () {
    UIViewController *controllerSix;
}

typedef void(^queueBlock)(int, int);

@end

@implementation PageFourVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 200, 200)];
    UIView *viewtwo = [[UIView alloc] initWithFrame:CGRectMake(0, 250, 200, 200)];
    UIView *viewThree = [[UIView alloc] initWithFrame:CGRectMake(200, 50, 200, 200)];
    UIView *viewFour = [[UIView alloc] initWithFrame:CGRectMake(200, 250, 200, 200)];
    UIView *viewFive = [[UIView alloc] initWithFrame:CGRectMake(0, 450, 200, 200)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateAction:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    
    tap.numberOfTapsRequired=1;
    tap.numberOfTouchesRequired=1;
    
    [view addGestureRecognizer:tap];
    [viewtwo addGestureRecognizer:pinch];
    [viewThree addGestureRecognizer:swipe];
    [viewFour addGestureRecognizer:rotate];
    [viewFive addGestureRecognizer:pan];

    view.backgroundColor=[UIColor blueColor];
    viewtwo.backgroundColor=[UIColor redColor];
    viewThree.backgroundColor=[UIColor greenColor];
    viewFour.backgroundColor=[UIColor yellowColor];
    viewFive.backgroundColor=[UIColor brownColor];
    
    [self.view addSubview:view];
    [self.view addSubview:viewtwo];
    [self.view addSubview:viewThree];
    [self.view addSubview:viewFour];
    [self.view addSubview:viewFive];
}

- (void)viewDidAppear:(BOOL)animated {
    queueBlock block;
    block= ^(int a, int b) {
        NSLog(@"block");
    };
    
    dispatch_queue_t queue;
    queue = dispatch_queue_create("queue", NULL);
    dispatch_async(queue, ^{
        NSLog(@"queue");
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://tineye.com/images/widgets/mona.jpg"]];
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"inside main queue");
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 450, 200, 200)];
            imageView.image=image;
            [self.view addSubview:imageView];
        });
    });
    
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", NULL);
    dispatch_async(queue2, ^{
        NSLog(@"queue 2 entered");
    });
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 650, 200, 100)];
    button.backgroundColor=[UIColor greenColor];
    [button setTitle:@"next view" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    controllerSix = [[PageFiveVC alloc]init];
}


- (void)tapAction:(UITapGestureRecognizer *)tap {
    NSLog(@"tapped");
}

- (void)buttonAction:(UIButton *)button {
    NSLog(@"button pressed");
    [self presentViewController:controllerSix animated:YES completion:nil];
}

- (void)pinchAction:(UIPinchGestureRecognizer *)pinch {
    NSLog(@"pinched");
    NSLog(@"SCALE: %f", pinch.scale);
    NSLog(@"velocity: %f", pinch.velocity);
}

- (void)swipeAction:(UISwipeGestureRecognizer *)swipe {
    NSLog(@"Swiped");
    NSLog(@"direction: %lu", (unsigned long)swipe.direction);
}

- (void)rotateAction:(UIRotationGestureRecognizer *)rotate {
    NSLog(@"rotation done");
    NSLog(@"rotation: %f", rotate.rotation);
    NSLog(@"velocity: %f", rotate.velocity);
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    NSLog(@"pan done");
    NSLog(@"rotation: %lu", (unsigned long)pan.minimumNumberOfTouches);
    NSLog(@"velocity: %lu", (unsigned long)pan.maximumNumberOfTouches);
}

@end


