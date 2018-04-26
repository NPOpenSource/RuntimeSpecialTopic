//
//  Person.m
//  RuntimeParseClass
//
//  Created by 温杰 on 2018/4/25.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "ObjcClassMethodParse.h"
@implementation Person
@dynamic name4;

- (instancetype)init
{
    self = [super init];
    if (self) {
    

    }
    return self;
}


@end
