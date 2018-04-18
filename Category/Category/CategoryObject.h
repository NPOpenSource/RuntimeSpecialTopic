//
//  CategoryObject.h
//  Category
//
//  Created by 温杰 on 2018/4/18.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CategoryObject : NSObject

@end

@interface CategoryObject(MyAddition)

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *value;

- (void)printName;
-(void)printValue;
@end
@interface CategoryObject(MyAddition2)
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *age;
@property(nonatomic, copy) NSString *address;
- (void)printName;
-(void)printAge;
-(void)printAddress;

@end
