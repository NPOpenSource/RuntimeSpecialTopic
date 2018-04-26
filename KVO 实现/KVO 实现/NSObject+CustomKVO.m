//
//  NSObject+CustomKVO.m
//  KVO 实现
//
//  Created by 温杰 on 2018/4/26.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "NSObject+CustomKVO.h"
#import <objc/message.h>
@implementation NSObject (CustomKVO)
-(void)CTKVO_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    
    //动态添加一个类 去重
    NSString *oldClassName = NSStringFromClass([self class]);
    Class myclass = NSClassFromString(oldClassName);
    SEL methodSel = NSSelectorFromString(@"_isKVOA");
    if ([oldClassName hasPrefix:@"CTKVO_"]) {
        BOOL is= objc_msgSend(self,methodSel);
        if (!is) {
            NSString *newClassName = [@"CTKVO_" stringByAppendingString:oldClassName];
            const char * newName = [newClassName UTF8String];
            myclass = objc_allocateClassPair([self class], newName, 0);
            class_addMethod(myclass, methodSel, (IMP)_isKVOA, "v@:");
            //注册新添加的这个类
            objc_registerClassPair(myclass);
            ///isa 改变
            object_setClass(self, myclass);
        }
    }else{
        NSString *newClassName = [@"CTKVO_" stringByAppendingString:oldClassName];
        const char * newName = [newClassName UTF8String];
        myclass = objc_allocateClassPair([self class], newName, 0);
        class_addMethod(myclass, methodSel, (IMP)_isKVOA, "v@:");
        //注册新添加的这个类
        objc_registerClassPair(myclass);
        ///isa 改变
        object_setClass(self, myclass);
    }
    
    NSMutableDictionary * keyPathDic= objc_getAssociatedObject(self, (__bridge const void *)@"kvo_keyPath");
    if (!keyPathDic) {
        keyPathDic= [NSMutableDictionary dictionary];
       objc_setAssociatedObject(self, (__bridge const void *)@"kvo_keyPath", keyPathDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSMutableArray * keyPathValueArr = nil;
    if (![keyPathDic objectForKey:keyPath]) {
        keyPathValueArr = [NSMutableArray array];
        [keyPathDic setObject:keyPathValueArr forKey:keyPath];
    }
    
    BOOL isHave = NO;
    for (NSDictionary * observerInfo in keyPathValueArr) {
       NSObject * obs = [observerInfo objectForKey:@"kvo_observer"];
        if (obs && obs == observer) {
            isHave = YES;
        }
    }
    if (!isHave) {
        NSMutableDictionary  * observerInfo= [NSMutableDictionary dictionary];
        [observerInfo setObject:observer forKey:@"kvo_observer"];
        [observerInfo setObject:@(options) forKey:@"kvo_options"];
        if (context) {
            [observerInfo setObject:(__bridge id)context forKey:@"kvo_context"];
        }
        [keyPathValueArr addObject:observerInfo];
    }
   ///alloc init
   NSArray * array= [keyPath componentsSeparatedByString:@"."];
    NSString * methodName = nil;
    if (array.count>0) {
        methodName = array[0];
    }
    methodName =[methodName capitalizedString];
    methodName =[[@"set" stringByAppendingString:methodName]stringByAppendingString:@":"];
     methodSel = NSSelectorFromString(methodName);
    class_addMethod(myclass, methodSel, (IMP)CustomKVOIMP, "v@:@");
 
}



//相当于重写父类的方法
void CustomKVOIMP(id self, SEL sel, id param) {
    
    NSMutableDictionary * keyPathDic= objc_getAssociatedObject(self, (__bridge const void *)@"kvo_keyPath");
    NSString * selName = NSStringFromSelector(sel);
    selName = [selName substringFromIndex:3];
    selName = [selName substringToIndex:selName.length-1];
    selName = [selName lowercaseString];
    NSMutableArray * selPathArr= [NSMutableArray array];
    for (NSString * key in keyPathDic.allKeys) {
       NSString * lKey = [key lowercaseString];
        if ([lKey hasPrefix:selName]) {
            [selPathArr addObject:key];
        }
    }
    
    for (NSString *keyPath in selPathArr) {
        ///所有观察者
        NSArray * array = [keyPathDic objectForKey:keyPath];
        //保存当前类
        Class myclass = [self class];
        //将self的isa指针指向父类
        object_setClass(self, class_getSuperclass([self class]));
        objc_msgSend(self, sel,param);
        
        NSArray * arrayPath= [keyPath componentsSeparatedByString:@"."];
        NSMutableArray * apaths =[NSMutableArray arrayWithArray:arrayPath];
        [apaths removeObjectAtIndex:0];
        NSString * path = [apaths componentsJoinedByString:@"."];

        SEL getMethod = NSSelectorFromString(selName);
        

        id getOldValue =objc_msgSend(self, getMethod);
        
        ///这里让path 的下面的对象 更改isa
        for (NSDictionary * info in array) {
            id obs = [info objectForKey:@"kvo_observer"];
            NSNumber * op = [info objectForKey:@"kvo_options"];
            void * content = (__bridge void *)([info objectForKey:@"kvo_context"]);
            NSMutableDictionary * dic=[NSMutableDictionary dictionary];
            if (getOldValue) {
                [dic setObject:getOldValue forKey:@"old"];
            }
            [dic setObject:param forKey:@"new"];

            objc_msgSend(obs,@selector(observeValueForKeyPath:ofObject:change:context:),keyPath,self,dic,content);
            
            if (path) {
                [param CTKVO_addObserver:obs forKeyPath:path options:op.intValue context:content];
            }
        }
        object_setClass(self, myclass);
    }
}

BOOL _isKVOA(id self, SEL sel){
    return YES;
}



@end
