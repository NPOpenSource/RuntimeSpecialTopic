//
//  main.m
//  测试Shifts 指针
//
//  Created by 温杰 on 2018/4/13.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *binaryWithInteger(NSUInteger decInt){
    NSString * string =@"";
    NSUInteger dec = decInt;
    while (dec>0) {
        string = [[NSString stringWithFormat:@"%lu",dec&1] stringByAppendingString:string];
        dec =dec>>1;
    }
    while(string.length!=64) {
        string = [@"0" stringByAppendingString:string];
    }
    return string;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        struct objc_object * obj = (__bridge  struct objc_object *)[NSObject new];
        NSLog(@"%@",binaryWithInteger(obj->isa));
        NSLog(@"%@", binaryWithInteger((uintptr_t)[NSObject class]));
    }
    return 0;
}
