#import "WHHXGUNMMAFN.h"
#import "AFNetworking.h"
@implementation WHHXGUNMMAFN
+ (void)xq_getDataWithParameters:(NSDictionary *)paramets withUrl:(NSString *)urlstr withBlock:(NetBlock)block{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSMutableSet *contentTypes = [[NSMutableSet alloc]initWithSet:manger.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    manger.responseSerializer.acceptableContentTypes = contentTypes;
    [manger GET:urlstr parameters:paramets progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
+ (void)xq_getDataWithParameters:(NSDictionary *)paramets withUrl:(NSString *)urlstr withBlock:(NetBlock)block withFailedBlock:(ErrorBlock) errorBlock{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSMutableSet *contentTypes = [[NSMutableSet alloc]initWithSet:manger.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    manger.responseSerializer.acceptableContentTypes = contentTypes;
    [manger GET:urlstr parameters:paramets progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}
+ (void)xq_getDataWithParameters:(NSDictionary *)paramets withUrl:(NSString *)urlstr withCachePath:(NSString *)cachePath withBlock:(NetBlock)block withFailedBlock:(ErrorBlock) errorBlock{
    if (!cachePath) {
        [self xq_getDataWithParameters:paramets withUrl:urlstr withBlock:block withFailedBlock:errorBlock];
        return;
    }
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSMutableSet *contentTypes = [[NSMutableSet alloc]initWithSet:manger.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    manger.responseSerializer.acceptableContentTypes = contentTypes;
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        NSData *data = [NSData dataWithContentsOfFile:cachePath options:0 error:nil];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        block(responseDic);
    } else {
        [manger GET:urlstr parameters:paramets progress:^(NSProgress * _Nonnull downloadProgress) {
            nil;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForKey:@"error_code"] integerValue] == 0) {
                if (![[NSFileManager defaultManager] fileExistsAtPath: cachePath]) {
                    BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:cachePath contents:nil attributes:nil];
                    NSLog(@"文件创建成功 = %d",isSuccess);
                }
                NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:NULL];
                NSError *error = nil;
                [data writeToFile:cachePath options:0 error:&error];
                if (error) {
                    NSLog(@"文件写入出错：\n%@",error);
                }
            }
            block(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
    }
}
@end
