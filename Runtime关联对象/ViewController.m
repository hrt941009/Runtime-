//
//  ViewController.m
//  Runtime关联对象
//
//  Created by henyep on 15/7/31.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
static char kDTActionHandlerTapGestureKey;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setTapActionWithBlock:^{
        NSLog(@"aaaaa");
    }];
}

-(void)setTapActionWithBlock:(void (^)(void))block{
    UITapGestureRecognizer *gesture=objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    if (!gesture) {
        gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self.view addGestureRecognizer:gesture];
    }
    objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, block, OBJC_ASSOCIATION_RETAIN);
}
- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
        
        if (action)
        {
            action();
        }
//        NSLog(@"11111111");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
