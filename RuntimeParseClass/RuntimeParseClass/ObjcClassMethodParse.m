//
//  ObjcClassMethodParse.m
//  RuntimeParseClass
//
//  Created by 温杰 on 2018/4/25.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "ObjcClassMethodParse.h"
#import <objc/runtime.h>



@interface ObjcClassMethod: NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) IMP imp;
@property (nonatomic,strong) NSString *ypeEncoding;
@property (nonatomic,assign) int  argumentCount;
@property (nonatomic,strong) NSString * cReturnType;
@property (nonatomic,strong) NSMutableArray *cArgumentTypes;
@property (nonatomic,strong) NSString * getReturnType;
@property (nonatomic,strong) NSMutableArray *gArgumentTypes;

@property (nonatomic,strong) NSString * descriptionName;
@property (nonatomic,strong) NSString * descriptionType;

@end

@implementation ObjcClassMethod

@end

@interface ObjcClassMethodParse()
@property (nonatomic,strong) Class cls;
@property (nonatomic,strong) NSMutableArray * methodListArr;
@end
@implementation ObjcClassMethodParse
- (instancetype)initWithClass:(Class)cls
{
    self = [super init];
    if (self) {
        self.cls = cls;
        self.methodListArr = [NSMutableArray array];
        [self parse];
        
    }
    return self;
}
//https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW1
-(void)parse{
    
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(self.cls, &count);
    for (int i=0; i<count; i++) {
        Method method = methodList[i];
        ObjcClassMethod * m=[[ObjcClassMethod alloc]init];
     const char * name= sel_getName(method_getName(method));
        
        m.name = [NSString stringWithFormat:@"%s",name];
        IMP imp= method_getImplementation(method);
        m.imp = imp;
      const char *ypeEncoding =  method_getTypeEncoding(method);
        m.ypeEncoding = [NSString stringWithFormat:@"%s",ypeEncoding];
       int count = method_getNumberOfArguments(method);
        m.argumentCount = count;
      const char *returnType =  method_copyReturnType(method);
        m.cReturnType = [NSString stringWithFormat:@"%s",returnType];
        NSMutableArray * argumentstype= [NSMutableArray array];
        for (int i=0; i<count; i++) {
          char * argumentType=  method_copyArgumentType(method, i);
            [argumentstype addObject:[NSString stringWithFormat:@"%s",argumentType]];
        }
        m.cArgumentTypes =argumentstype;
        char  dst[1024]={0};
        method_getReturnType(method,dst , 1024);
        m.getReturnType =[NSString stringWithFormat:@"%s",dst];
        
        NSMutableArray * gargumentstype= [NSMutableArray array];

        for (int i=0; i<count; i++) {
            char  dst[1024]={0};
            method_getArgumentType(method, i, dst, 1024);
            [gargumentstype addObject:[NSString stringWithFormat:@"%s",dst]];
        }
        m.gArgumentTypes = gargumentstype;
       
        struct objc_method_description * de=   method_getDescription(method);
        m.descriptionName = NSStringFromSelector(de->name);
        m.descriptionType =[NSString stringWithFormat:@"%s", de->types];
        [self.methodListArr addObject:m];
    }
    free(methodList);
    
}

-(void)print{
    for (ObjcClassMethod *m in self.methodListArr) {
        NSString * str = [NSString stringWithFormat:@"name=%@, imp=%p ,typeEncoding=%@ ,argumentCount=%d,cReturnType=%@,getReturnType=%@,descriptionName=%@,descriptionType=%@,cArgumentTypes=%@,gArgumentTypes=%@",m.name ,m.imp,m.ypeEncoding,m.argumentCount,m.cReturnType,m.getReturnType,m.descriptionType,m.descriptionType,[m.cArgumentTypes componentsJoinedByString:@"|"],[m.gArgumentTypes componentsJoinedByString:@"|"]];
        NSLog(@"%@",str);
        
        
    }
}

@end
