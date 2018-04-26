//
//  NSObject+CustomKVO.h
//  KVO 实现
//
//  Created by 温杰 on 2018/4/26.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CustomKVO)
-(void)CTKVO_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
@end
