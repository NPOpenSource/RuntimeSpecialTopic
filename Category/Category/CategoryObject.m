//
//  CategoryObject.m
//  Category
//
//  Created by 温杰 on 2018/4/18.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "CategoryObject.h"

@implementation CategoryObject
- (void)printName
{
    NSLog(@"%@",@"CategoryObject");
}
@end

@implementation CategoryObject(MyAddition)

- (void)printName
{
    NSLog(@"printName %@",@"MyAddition");
}
-(void)printValue{
    NSLog(@"printValue %@",@"MyAddition");
}

@end

@implementation CategoryObject(MyAddition2)
-(void)printAge{
    NSLog(@"printAge %@",@"MyAddition2");

}
-(void)printAddress{
    NSLog(@"printAddress %@",@"MyAddition2");

}
- (void)printName
{
    NSLog(@"printName %@",@"MyAddition2");
}

@end

