//
//  LZXThread.h
//  LZXThread
//
//  Created by 海底捞lzx on 2016/11/1.
//  Copyright © 2016年 海底捞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZXThread : NSObject

/** 线程名 */
@property (nonatomic, copy) NSString *name;

/** 线程 */
@property (nonatomic, strong) NSThread *thread;

/** 运行循环 */
@property (nonatomic, strong) NSRunLoop *runloop;

/** 运行循环的模式，默认是 NSDefaultMode */
@property (nonatomic, copy) NSRunLoopMode mode;


/**
 默认是 NSDefaultMode 模式
 */
+ (instancetype)thread;

/**
 指定线程的模式
 */
+ (instancetype)threadInMode:(NSRunLoopMode)mode withName:(NSString *)name;

/**
 指定线程的模式
 */
- (instancetype)initWithMode:(NSRunLoopMode)mode withName:(NSString *)name;

/**
 向线程中添加操作,默认取消之前一次的该操作
 @param target 子线程中要执行的方法的目标
 @param selector 子线程中要执行的操作
 */
- (void)addOprationOnTarget:(NSObject *)target withSelector:(SEL)selector;


/**
 向线程中添加操作
 @param target 子线程中要执行的方法的目标
 @param selector 子线程中要执行的操作
 @param cancel 执行前是否取消调用之前添加进去的该操作
 */
- (void)addOprationOnTarget:(NSObject *)target withSelector:(SEL)selector cancelPreviousSameOption:(BOOL)cancel;

@end
