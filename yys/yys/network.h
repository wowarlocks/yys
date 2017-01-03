//
//  network.h
//  yys
//
//  Created by xiong on 2017/1/3.
//  Copyright © 2017年 xiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "offerRewardModel.h"
#import <Ono.h>
#import <AFNetworking.h>
//成功之后返回值
typedef void(^success)(id array);
typedef void(^error)(NSError *error);
@interface network : NSObject
+(instancetype)manger;
-(void)checkUpDataSuccees:(success)Success Error:(error)Error;;
@end
