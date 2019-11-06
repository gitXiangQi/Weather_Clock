#import <Foundation/Foundation.h>
typedef void (^NetBlock)(id result);
typedef void (^ErrorBlock)(NSError *error);
@interface WHHXGUNMMAFN : NSObject
+ (void)xq_getDataWithParameters:(NSDictionary *)paramets withUrl:(NSString *)urlstr withBlock:(NetBlock)block;
+ (void)xq_getDataWithParameters:(NSDictionary *)paramets withUrl:(NSString *)urlstr withBlock:(NetBlock)block withFailedBlock:(ErrorBlock) errorBlock;
+ (void)xq_getDataWithParameters:(NSDictionary *)paramets withUrl:(NSString *)urlstr withCachePath:(NSString *)cachePath withBlock:(NetBlock)block withFailedBlock:(ErrorBlock) errorBlock;
@end
