//
//  ViewController.m
//  LZXThreadDemo
//
//  Created by 海底捞lzx on 2016/11/2.
//  Copyright © 2016年 海底捞. All rights reserved.
//

#import "ViewController.h"
#import "LZXThread.h"

@interface ViewController ()

@property (nonatomic, strong) LZXThread *lzxThread;

@property (nonatomic, assign) NSInteger idx;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _lzxThread = [LZXThread threadInMode:UITrackingRunLoopMode withName:@"业务处理子线程"];
    _idx = 0;
    [NSThread mainThread].name = @"主线程";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self addOperation];
    [self performSelector:@selector(addOperation) withObject:nil afterDelay:1];
}

- (void)addOperation {
    _idx += 1;
    NSLog(@"\n--【Add】: %zd - %@ - Mode: %@", _idx, [NSThread currentThread].name, [NSRunLoop currentRunLoop].currentMode);
    [_lzxThread addOprationOnTarget:self withSelector:@selector(operate) cancelPreviousSameOption:YES];
}

- (void)operate {
    NSLog(@"\n--【Excute】: %zd - %@ - Mode: %@", _idx, [NSThread currentThread].name, [NSRunLoop currentRunLoop].currentMode);
    [NSThread sleepForTimeInterval:2]; // 延时2秒，模拟耗时操作
    NSLog(@"\n--【Finish】: %zd - %@ - Mode: %@", _idx, [NSThread currentThread].name, [NSRunLoop currentRunLoop].currentMode);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"Scrolling -- MAIN-- %@", [NSRunLoop currentRunLoop].currentMode);
    NSLog(@"Scrolling -- LZXThread -- %@", self.lzxThread.runloop.currentMode);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"EndScroll -- MAIN -- %@", [NSRunLoop currentRunLoop].currentMode);
    NSLog(@"Scrolling -- LZXThread -- %@", self.lzxThread.runloop.currentMode);
}


@end
