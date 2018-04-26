//
//  Person.h
//  RuntimeParseClass
//
//  Created by 温杰 on 2018/4/25.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Son.h"
struct personStruct{
    int man ;
};

@interface Person : NSObject

@property (nonatomic,assign) struct personStruct structSon;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,retain) NSString *name1;
@property (nonatomic,copy) NSString *name2;
@property (atomic,copy) NSString *name3;
@property (nonatomic,strong) NSString *name4;
@property (nonatomic,weak) NSString *name5;
@property (nonatomic,getter=isEmpty) int mm;
@property (nonatomic,setter=isdd:) int mmd;
@property (nonatomic,strong) Son  *son;
@property (nonatomic,strong) NSMutableArray *address;
-(void)addAddress:(NSString *)address;
@end
