#import "WHHXSingleton.h"
#import "BirthdayCellModel.h"
#import <Foundation/Foundation.h>
@implementation WHHXSingleton
+ (instancetype)sharedInstance {
    static WHHXSingleton *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
@end
