//
//  ViewController.m
//  MoveFiles
//
//  Created by 令令孟 on 2018/11/13.
//  Copyright © 2018 令令孟. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self moveFilesWithGCD];
}

- (void)moveFiles {
    NSString *from = @"/Users/linglingmeng/Desktop/iOS书籍";
    NSString *to = @"/Users/linglingmeng/Desktop/to";
    
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsAtPath:from];
    NSInteger count = filesArray.count;
    for (NSInteger i = 0; i<count; i++) {
        NSString *fullPath = [from stringByAppendingPathComponent:filesArray[i]];
        NSString *toFullPath = [to stringByAppendingPathComponent:filesArray[i]];
        
        [[NSFileManager defaultManager] moveItemAtPath:fullPath toPath:toFullPath error:nil];
                                
                              
    }
    
}

- (void)moveFilesWithGCD {
    
    NSString *from = @"/Users/linglingmeng/Desktop/iOS书籍";
    NSString *to = @"/Users/linglingmeng/Desktop/to";
    
    NSArray *filesArray = [[NSFileManager defaultManager] subpathsAtPath:from];
    NSInteger count = filesArray.count;
    // apply 快速迭代，会开子线程，并发执行
    // 队列参数一定要是并发队列
    dispatch_apply(count, dispatch_get_global_queue(0, 0), ^(size_t i) {
        NSString *fullPath = [from stringByAppendingPathComponent:filesArray[i]];
        NSString *toFullPath = [to stringByAppendingPathComponent:filesArray[i]];
        
        [[NSFileManager defaultManager] moveItemAtPath:fullPath toPath:toFullPath error:nil];
        
        NSLog(@"%@ ",[NSThread currentThread]);
    });
}

@end
