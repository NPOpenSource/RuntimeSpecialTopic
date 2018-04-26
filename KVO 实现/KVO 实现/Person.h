//
//  Person.h
//  KVO 实现
//
//  Created by 温杰 on 2018/4/26.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Man.h"
@interface Person : NSObject
@property (nonatomic,strong) Man *man;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) int carId;
@end
