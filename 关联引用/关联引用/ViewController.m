//
//  ViewController.m
//  关联引用
//
//  Created by 温杰 on 2018/4/18.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()

@end


@implementation ViewController

static NSString *_strFlag;


void ddd(void){
    
}

-(void)addValue{
    objc_setAssociatedObject(self, &_strFlag, @"你好", OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
-(void)getvaule{
  NSString * str =   objc_getAssociatedObject(self, &_strFlag);
    NSLog(@"getValue %@",str);
}
-(void)changeValue{
    objc_setAssociatedObject(self, &_strFlag, @"挺好的", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self getvaule];

}
-(void)deleteValue{
    objc_setAssociatedObject(self, &_strFlag, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self getvaule];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addValue];
    [self getvaule   ];
    [self changeValue];
    [self deleteValue];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
