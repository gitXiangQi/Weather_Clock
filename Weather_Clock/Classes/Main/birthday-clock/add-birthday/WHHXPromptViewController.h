#import <UIKit/UIKit.h>
typedef void(^returnNewPrompt)(NSString *newPrompt);
@interface WHHXPromptViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextInputTraits>
@property (nonatomic, copy) NSString *prompt;
@property (nonatomic, strong) UITableView *promptTable;
@property (nonatomic, copy)  returnNewPrompt returnNewPromptBlock;
@end
