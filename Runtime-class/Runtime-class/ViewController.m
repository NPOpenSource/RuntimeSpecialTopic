//
//  ViewController.m
//  Runtime-class
//
//  Created by 温杰 on 2018/4/13.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "YoungMan.h"
@interface ViewController ()

@end

@implementation ViewController
-(void)printClassInfo:(char *)className{
    Class objectClass;
    Class superClass;
    Class metaClass;
    Class superMetaClass;
    objectClass= objc_getClass(className);
    superClass= class_getSuperclass(objectClass);
    metaClass=  objc_getMetaClass(className);
    superMetaClass= class_getSuperclass(metaClass);
    struct objc_object * obj = (__bridge  struct objc_object *)metaClass;
    NSLog(@"className %s objectClass %p  superClass %p metaClass %p superMetaClass %p metaClass isa %p ",className,objectClass,superClass,metaClass,superMetaClass,obj->isa);
}


- (void)viewDidLoad {
    [super viewDidLoad];

//    [self printClassInfo:"YoungMan"];
//    [self printClassInfo:"Man"];
//    [self printClassInfo:"Persion"];
//    [self printClassInfo:"NSObject"];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
