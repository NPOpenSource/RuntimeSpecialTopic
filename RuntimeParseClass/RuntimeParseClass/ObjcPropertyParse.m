//
//  ObjcPropertyParse.m
//  RuntimeParseClass
//
//  Created by 温杰 on 2018/4/25.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "ObjcPropertyParse.h"
#import <objc/runtime.h>




@interface ObjcProperty: NSObject
@property (nonatomic,strong) NSString *property;
@property(nonatomic ,assign) bool isRetain;
@property(nonatomic ,assign) bool isCopy;
@property(nonatomic ,assign) bool isNonatomic;
@property(nonatomic ,assign) NSString * isGetter;
@property(nonatomic ,assign) NSString * isSetter;
@property(nonatomic ,assign) bool isdynamic;
@property(nonatomic ,assign) bool isWeak;
@property(nonatomic ,assign) bool isP;
@property(nonatomic ,assign) NSString  * isT;
@property (nonatomic,strong) NSString *ivar;
@property (nonatomic ,strong)NSString * propertyName;

@end

@implementation ObjcProperty

@end

@interface ObjcPropertyParse()
@property (nonatomic,strong) Class cls;
@property (nonatomic,strong) NSMutableArray * propertyList;
@end

@implementation ObjcPropertyParse
- (instancetype)initWithClass:(Class)cls
{
    self = [super init];
    if (self) {
        self.cls = cls;
        self.propertyList = [NSMutableArray array];
        [self parse];
       
    }
    return self;
}
//https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW1
-(void)parse{

    unsigned int count = 0;
    objc_property_t *property_t = class_copyPropertyList(self.cls, &count);
    for (int i=0; i<count; i++) {
        objc_property_t propert = property_t[i];
        const char * propertyName = property_getName(propert);

    unsigned int attcount = 0;
       objc_property_attribute_t *att = property_copyAttributeList(propert,&attcount);
        ObjcProperty * objc=[[ObjcProperty alloc]init];
        objc.propertyName = [NSString stringWithFormat:@"%s",propertyName];
        for (int j =0; j<attcount; j++) {
            objc_property_attribute_t t = att[j];
            if (strcmp(t.name,"T")==0) {
                objc.property = [NSString stringWithFormat:@"%s",t.value];
            }
            if (strcmp(t.name,"&")==0) {
                objc.isRetain = YES;
            }
            if (strcmp(t.name,"&")==0) {
                objc.isRetain = YES;
            }
            if (strcmp(t.name,"N")==0) {
                objc.isNonatomic = YES;
            }
            if (strcmp(t.name,"D")==0) {
                objc.isdynamic = YES;
            }
            if (strcmp(t.name,"G")==0) {
                objc.isGetter =  [NSString stringWithFormat:@"%s",t.value];
            }
            if (strcmp(t.name,"S")==0) {
                objc.isSetter =  [NSString stringWithFormat:@"%s",t.value];
            }
            if (strcmp(t.name,"W")==0) {
                objc.isWeak = YES;
            }
            
            if (strcmp(t.name,"P")==0) {
                objc.isP = YES;
            }
            if (strcmp(t.name,"t")==0) {
                objc.isT =  [NSString stringWithFormat:@"%s",t.value];;
            }
            if (strcmp(t.name,"V")==0) {
                objc.ivar =  [NSString stringWithFormat:@"%s",t.value];;

            }
        }
        [self.propertyList addObject:objc];
    
    }
    free(property_t);

}

-(void)print{
    for (ObjcProperty * objcProperty in self.propertyList) {
        NSLog(@" propertyName=%@,property=%@,isCopy=%d,isRetain=%d,isNonatomic=%d,isGetter=%@,isSetting=%@,isDynamic=%d,isWeak=%d,isP=%d,isT=%@,Ivar=%@",objcProperty.propertyName,objcProperty.property,objcProperty.isCopy,objcProperty.isRetain,objcProperty.isNonatomic,objcProperty.isGetter,objcProperty.isSetter,objcProperty.isdynamic,objcProperty.isWeak,objcProperty.isWeak,objcProperty.isT,objcProperty.ivar);
    
    
    }
}


@end
