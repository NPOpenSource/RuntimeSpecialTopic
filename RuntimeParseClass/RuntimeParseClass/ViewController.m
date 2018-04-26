//
//  ViewController.m
//  RuntimeParseClass
//
//  Created by 温杰 on 2018/4/25.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "ObjcPropertyParse.h"
#import "ObjcClassMethodParse.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    ObjcPropertyParse * objcPropertyParse = [[ObjcPropertyParse alloc]initWithClass:[Person class]];
//
//    [objcPropertyParse print];

    ObjcClassMethodParse * methodParse =[[ObjcClassMethodParse alloc]initWithClass:[Person class]];
    [methodParse print];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
