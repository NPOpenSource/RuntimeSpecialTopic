//
//  ViewController.m
//  Category
//
//  Created by 温杰 on 2018/4/18.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "ViewController.h"
#import "CategoryObject.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Class  currentClass=  [CategoryObject class];
    CategoryObject *obj = [[CategoryObject alloc]init];
    if (currentClass) {
        unsigned int methodCount;
        Method *methodList = class_copyMethodList(currentClass, &methodCount);
        IMP lastImp = NULL;
        SEL lastSel = NULL;
        for (NSInteger i = 0; i < methodCount; i++) {
            Method method = methodList[i];
            NSString *methodName = [NSString stringWithCString:sel_getName(method_getName(method))
                                                      encoding:NSUTF8StringEncoding];
            if ([@"printName" isEqualToString:methodName]) {
                lastImp = method_getImplementation(method);
                lastSel = method_getName(method);
                typedef void (*fn)(id,SEL);
                if (lastImp != NULL) {
                    fn f = (fn)lastImp;
                    f(obj,lastSel);
                }
            }
           
        }
       
        free(methodList);
    }
    
    
    


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
