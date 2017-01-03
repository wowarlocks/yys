//
//  offerRewardModel.h
//  yys
//
//  Created by xiong on 2017/1/3.
//  Copyright © 2017年 xiong. All rights reserved.
//

#import <Foundation/Foundation.h>


@class  monster;
@interface offerRewardModel : NSObject
@property(strong, nonatomic) NSString *chaper;
@property(strong, nonatomic) NSMutableArray <monster *> *monsterArray;
@end

@interface monster : NSObject
//怪物名
@property(strong, nonatomic) NSString *monsterName;
//怪物数量
@property(strong, nonatomic) NSString *monsterCount;
@end
