//
//  ViewController.m
//  GetterSetterObjectiveC
//
//  Created by DMITRY SINYOV on 31.07.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "ViewController.h"
#import "TestableGetSet.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beginTestButtonTouched:(id)sender
{
    TestableGetSet *getSet = [[TestableGetSet alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self firstWriter:getSet];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self secondWriter:getSet];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self reader:getSet];
    });
    
    
//    NSThread *threadWriter1 = [[NSThread alloc] initWithTarget:self selector:@selector(firstWriter:) object:getSet];
//    NSThread *threadWriter2 = [[NSThread alloc] initWithTarget:self selector:@selector(secondWriter:) object:getSet];
//    NSThread *threadReader = [[NSThread alloc] initWithTarget:self selector:@selector(reader:) object:getSet];
//    
//    [threadWriter1 start];
//    [threadWriter2 start];
//    [threadReader start];
//    
//    [threadWriter1 release];
//    [threadWriter2 release];
//    [threadReader release];
    
    [getSet release];
}

-(void)firstWriter:(TestableGetSet*)testObject {
    for (long i = 0; i < 1000; i++) {
        testObject.testField = [NSString stringWithFormat:@"first %ld", i];
    }
}
-(void)secondWriter:(TestableGetSet*)testObject {
    for (long i = 0; i < 1000; i++) {
        testObject.testField = [NSString stringWithFormat:@"second %ld", i];
    }
}
-(void)reader:(TestableGetSet*)testObject {
    for (long i = 0; i < 100; i++) {
        NSLog(@"current %@", testObject.testField);
    }
}


@end
