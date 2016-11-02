//
//  LZXThread.m
//  LZXThread
//
//  Created by 海底捞lzx on 2016/11/1.
//  Copyright © 2016年 海底捞. All rights reserved.
//

#import "LZXThread.h"

@interface LZXThread ()

@property (nonatomic, strong) NSPort *port;

@end

@implementation LZXThread


+ (instancetype)thread {
    return [self threadInMode:NSDefaultRunLoopMode withName:@""];
}

+ (instancetype)threadInMode:(NSRunLoopMode)mode  withName:(NSString *)name {
    return [[self alloc] initWithMode:mode withName:name];
}

- (instancetype)initWithMode:(NSRunLoopMode)mode  withName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
        _mode = mode;
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(initThread) object:nil];
        [_thread start];
    }
    return self;
}

- (void)initThread {
    [[NSThread currentThread] setName:_name];
    _runloop = [NSRunLoop currentRunLoop];
    _port = [NSMachPort port];
    [_runloop addPort:_port forMode:NSDefaultRunLoopMode];
    [_runloop run];
}

- (void)setMode:(NSRunLoopMode)mode {
    if (self.port) {
        // 切换 mode
        [self.runloop addPort:self.port forMode:mode];
        [self.runloop removePort:self.port forMode:_mode];
    }
    _mode = mode;
}

- (void)addOprationOnTarget:(NSObject *)target withSelector:(SEL)selector {
    [self addOprationOnTarget:target withSelector:selector cancelPreviousSameOption:YES];
}

- (void)addOprationOnTarget:(NSObject *)target withSelector:(SEL)selector cancelPreviousSameOption:(BOOL)cancel {
    if (cancel) {
        [NSObject cancelPreviousPerformRequestsWithTarget:target selector:selector object:nil];
    }
    [target performSelector:selector onThread:self.thread withObject:nil waitUntilDone:NO modes:@[self.mode]];
}

- (void)releaseThread {
    [self.runloop removePort:self.port forMode:NSDefaultRunLoopMode];
    [self.thread cancel];
}

@end
