//
//  ViewController.m
//  KVO 实现
//
//  Created by 温杰 on 2018/4/25.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "ObjcClassMethodParse.h"
#import "NSObject+CustomKVO.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController
-(void)test{
    Person * p=[[Person alloc]init];
    struct objc_object * obj = (__bridge  struct objc_object *)p;
    Class objClass = obj->isa;
    NSLog(@"%@",objClass);
    ObjcClassMethodParse * methodParse =[[ObjcClassMethodParse alloc]initWithClass:objClass];
    [methodParse print];
    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    [p addObserver:self forKeyPath:@"man.age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    obj = (__bridge  struct objc_object *)p;
    objClass = obj->isa;
    NSLog(@"%@",objClass);
    
 
    
    methodParse =[[ObjcClassMethodParse alloc]initWithClass:objClass];
    [methodParse print];
    p.name = @"KVO";
    NSLog(@"man 赋值给p前函数");
    Man * man = [[Man alloc]init];
    obj = (__bridge  struct objc_object *)man;
    objClass = obj->isa;
    NSLog(@"%@",objClass);
    methodParse =[[ObjcClassMethodParse alloc]initWithClass:objClass];
    [methodParse print];
    NSLog(@"man 赋值给后前函数");
    p.man = man;
    obj = (__bridge  struct objc_object *)man;
    objClass = obj->isa;
    NSLog(@"%@",objClass);
    methodParse =[[ObjcClassMethodParse alloc]initWithClass:objClass];
    [methodParse print];
    NSLog(@"====end");
    man.age = @"18";
    obj = (__bridge  struct objc_object *)man;
    objClass = obj->isa;
    
    
    NSLog(@"%@",objClass);
    methodParse =[[ObjcClassMethodParse alloc]initWithClass:objClass];
    [methodParse print];
}
-(void)test2{
    Person * p=[[Person alloc]init];
    [p CTKVO_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [p CTKVO_addObserver:self forKeyPath:@"carId" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [p CTKVO_addObserver:self forKeyPath:@"man.age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    Man * man = [[Man alloc]init];
    p.man = man;
    man.age = @"18";

    
}
-(void)test4{
    Person * p=[[Person alloc]init];
    struct objc_object * obj = (__bridge  struct objc_object *)p;
    Class objClass = obj->isa;
    NSLog(@"%@",objClass);
    ObjcClassMethodParse * methodParse =[[ObjcClassMethodParse alloc]initWithClass:objClass];
    [methodParse print];
    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [p addObserver:self forKeyPath:@"man.age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    obj = (__bridge  struct objc_object *)p;
    objClass = obj->isa;
    NSLog(@"%@",objClass);
    void * mm = &objClass;
    SEL sel = NSSelectorFromString(@"_isKVOA");
    bool is= objc_msgSend((__bridge id)mm, sel);
    NSLog(@"%d" ,is);
    methodParse =[[ObjcClassMethodParse alloc]initWithClass:objClass];
    [methodParse print];
    
}

-(void)test1{
    Person * p=[[Person alloc]init];
    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [p addObserver:self forKeyPath:@"carId" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [p addObserver:self forKeyPath:@"man.age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    Man * man = [[Man alloc]init];
    p.man = man;
    man.age = @"18";

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test4];
//    [self test];
//    [self test1];
//    [self test2];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"keyPath=%@ object=%@ change=%@ context=%@",keyPath,object,change,context);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
