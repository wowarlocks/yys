//
//  network.m
//  yys
//
//  Created by xiong on 2017/1/3.
//  Copyright © 2017年 xiong. All rights reserved.
//

#import "network.h"




@implementation network
static AFHTTPSessionManager *manger = nil;
static network *shareInstance = nil;
+(instancetype)manger{

    @synchronized (self) {
        if (!shareInstance) {
            shareInstance = [[[self class] alloc] init];
            manger = [AFHTTPSessionManager manager];
            manger.responseSerializer = [AFHTTPResponseSerializer serializer];
            manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            

        }
    }
    return shareInstance;

}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized (self) {
        if (!shareInstance) {
            shareInstance = [super allocWithZone:zone];
            manger = [AFHTTPSessionManager manager];
            manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            manger.responseSerializer = [AFHTTPResponseSerializer serializer];
            return shareInstance;
        }
    }
    return nil;
}
-(void)checkUpDataSuccees:(success)Success Error:(error)Error{
    
    [manger  GET:@"http://nixin.online/yys/" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Success([self analysisWithHtml:responseObject]);
//        NSString *test = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSError *error;
//        ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithString:test  encoding:NSUTF8StringEncoding error:&error];
//        NSLog(@"error%@",error);
        
        //        //御魂
        //        [document enumerateElementsWithCSS:@".equipment" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        //            NSLog(@"element.count is %@", [element stringValue]);
        //        }];
        //探索
//        [document enumerateElementsWithCSS:@".explore" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
//            for (ONOXMLDocument *temp in element.children) {
//                __block offerRewardModel *model = [offerRewardModel new];
//                model.monsterArray = [NSMutableArray new];
//                [temp enumerateElementsWithCSS:@".table-row" usingBlock:^(ONOXMLElement *element2, NSUInteger idx2, BOOL *stop2) {
//                    
//                    if (idx2 == 0) {
//                        //章节名
//                        NSString *chapetr = [element2.children.firstObject stringValue];
//                        if (chapetr) {
//                            model.chaper = chapetr;
//                        }else{
//                            model.chaper =  [element2.children.lastObject stringValue];
//                        }
//                        
//                    }else{
//                        monster *monsters     = [monster new];
//                        monsters.monsterName  = [element2.children.firstObject stringValue];
//                        monsters.monsterCount = [element2.children.lastObject  stringValue];
//                        [model.monsterArray addObject:monsters];
//                    }
//                    
//                    
//                    
//                }];
//                [datasouce addObject:model];
//            }
//            
//        }];
//        NSLog(@"datasource count is %@", datasouce);
        //        //妖气
        //        [document enumerateElementsWithCSS:@".monster" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        //            NSLog(@"element.count is %@", [element stringValue]);
        //        }];
        //        //神秘
        //        [document enumerateElementsWithCSS:@".clue" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        //            NSLog(@"element.count is %@", [element stringValue]);
        //        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR%@",error);
        Error(error);
    }];

}
-(NSArray *)analysisWithHtml:(id)response{
    NSString *test = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSError *error;
    ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithString:test  encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"error%@",error);
//     //探索
//    [self analysisWithClass:@".explore" andSource:document];
//    [self analysisWithClass:@".equipment" andSource:document];
//    [self analysisWithClass:@".monster" andSource:document];
//    [self analysisWithClass:@".clue" andSource:document];
    
    return @[
             [self analysisWithClass:@".explore" andSource:document],
             [self analysisWithClass:@".equipment" andSource:document],
             [self analysisWithClass:@".monster" andSource:document],
             [self analysisWithClass:@".clue" andSource:document]
             ];
    
//
//    [document enumerateElementsWithCSS:@".explore" usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
//        for (ONOXMLDocument *temp in element.children) {
//            __block offerRewardModel *model = [offerRewardModel new];
//            model.monsterArray = [NSMutableArray new];
//            [temp enumerateElementsWithCSS:@".table-row" usingBlock:^(ONOXMLElement *element2, NSUInteger idx2, BOOL *stop2) {
//                
//                if (idx2 == 0) {
//                    //章节名
//                    NSString *chapetr = [element2.children.firstObject stringValue];
//                    if (chapetr) {
//                        model.chaper = chapetr;
//                    }else{
//                        model.chaper =  [element2.children.lastObject stringValue];
//                    }
//                    
//                }else{
//                    monster *monsters     = [monster new];
//                    monsters.monsterName  = [element2.children.firstObject stringValue];
//                    monsters.monsterCount = [element2.children.lastObject  stringValue];
//                    [model.monsterArray addObject:monsters];
//                }
//                
//                
//                
//            }];
//            [datasouce addObject:model];
//        }
//        
//    }];

}
-(NSMutableArray *)analysisWithClass:(NSString *)className andSource:(ONOXMLDocument *)document{
    __block NSMutableArray *datasouce = [NSMutableArray new];
    [document enumerateElementsWithCSS:className usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        for (ONOXMLDocument *temp in element.children) {
            __block offerRewardModel *model = [offerRewardModel new];
            model.monsterArray = [NSMutableArray new];
            [temp enumerateElementsWithCSS:@".table-row" usingBlock:^(ONOXMLElement *element2, NSUInteger idx2, BOOL *stop2) {
                
                if (idx2 == 0) {
                    //章节名
                    if ([className isEqualToString:@".clue"]) {
                        model.chaper = @"神秘线索";
                    }else{
                        NSString *chapetr = [element2.children.firstObject stringValue];
                        if (chapetr) {
                            model.chaper = chapetr;
                        }else{
                            model.chaper =  [element2.children.lastObject stringValue];
                        }
                    
                    }

                    
                }else{
                    monster *monsters     = [monster new];
                    monsters.monsterName  = [element2.children.firstObject stringValue];
                    monsters.monsterCount = [element2.children.lastObject  stringValue];
                    [model.monsterArray addObject:monsters];
                }
                
                
                
            }];
            if (model.chaper) {
                [datasouce addObject:model];
            }
            
        }
        
    }];
    return datasouce;


}
@end
