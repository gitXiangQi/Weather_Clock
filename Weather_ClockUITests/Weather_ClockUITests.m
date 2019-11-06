#import <XCTest/XCTest.h>
@interface Weather_ClockUITests : XCTestCase
@end
@implementation Weather_ClockUITests
- (void)setUp {
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}
- (void)tearDown {
}
- (void)testExample {
}
@end
