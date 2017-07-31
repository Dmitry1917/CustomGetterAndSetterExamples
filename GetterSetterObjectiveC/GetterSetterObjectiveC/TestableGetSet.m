//
//  TestableGetSet.m
//  GetterSetterObjectiveC
//
//  Created by DMITRY SINYOV on 31.07.17.
//  Copyright © 2017 DMITRY SINYOV. All rights reserved.
//

#import "TestableGetSet.h"

@implementation TestableGetSet
{
    NSString *_testField;
    dispatch_queue_t localSyncQueue;
    NSLock *localLock;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        localSyncQueue = dispatch_queue_create(@"localSyncQueue".UTF8String, dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_UTILITY, -1));
        localLock = [[NSLock alloc] init];
    }
    return self;
}
-(void)dealloc
{
    dispatch_release(localSyncQueue);
    
    [localLock release];
    
    [_testField release];
    
    [super dealloc];
}

//без потокобезопасности
//-(NSString*)testField
//{
//    return _testField;
//}
//-(void)setTestField:(NSString *)testField
//{
//    [_testField release];
//    _testField = [testField copy];
//}

//через очередь
//-(NSString*)testField
//{
//    __block NSString *field = nil;
//    dispatch_sync(localSyncQueue, ^{
//        field = [[_testField copy] autorelease];
//    });
//    return field;
//}
//-(void)setTestField:(NSString *)testField
//{
//    dispatch_barrier_async(localSyncQueue, ^{
//        [_testField release];
//        _testField = [testField copy];
//    });
//}

//через mutex
-(NSString*)testField
{
    [localLock lock];
    NSString *field = [[_testField copy] autorelease];
    [localLock unlock];
    return field;
}
-(void)setTestField:(NSString *)testField
{
    [localLock lock];
    [_testField release];
    _testField = [testField copy];
    [localLock unlock];
}

@end
