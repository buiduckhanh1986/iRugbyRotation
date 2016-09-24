//
//  ViewController.m
//  iRugbyRotation
//
//  Created by Bui Duc Khanh on 9/24/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView * rugby;
    
    NSTimer* timer;
    
    CGFloat rotationVelocity;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initGUI];
    
    
    UIRotationGestureRecognizer* rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateRugby:)];
    
    [rugby addGestureRecognizer:rotation];
    
    
    rotationVelocity = 0;
}


// Huỷ timer khi kết thúc chương trình
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (timer != nil)
    {
        [timer invalidate];
        
        timer = nil;
    }
}


// Khởi tạo giao diện
- (void) initGUI{
    rugby = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rugby.png"]];
    rugby.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    rugby.multipleTouchEnabled = true;
    rugby.userInteractionEnabled = true;
    
    [self.view addSubview:rugby];
}

- (void) rotateRugby: (UIRotationGestureRecognizer*) rotation{
    if (rotation.state == UIGestureRecognizerStateBegan || rotation.state == UIGestureRecognizerStateChanged) {
        
        if (timer != nil)
        {
            [timer invalidate];
            
            timer = nil;
        }
        
        rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
        rotationVelocity = rotation.velocity/60.0; // Speed in 1/60.0
        
        rotation.rotation = 0.0;
    }
    else if (rotation.state == UIGestureRecognizerStateRecognized)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:(1/60.0)
                                                 target:self
                                               selector:@selector(loop)
                                               userInfo:nil
                                                repeats:true];
    }
        
}

- (void) loop {
    rugby.transform = CGAffineTransformRotate(rugby.transform, rotationVelocity);
    
    rotationVelocity = rotationVelocity * 0.95;
}
@end
