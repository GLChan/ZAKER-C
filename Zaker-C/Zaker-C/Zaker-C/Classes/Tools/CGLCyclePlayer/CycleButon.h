

#import <UIKit/UIKit.h>
#import "ZKRRotationItem.h"
@interface CycleButon : UIButton

/** 每个模型的类型,用来区分广告和其他类别,广告类别的标签在左下角 */
@property (nonatomic, strong) NSString *tag_type;

@property (nonatomic, strong) ZKRRotationItem *item;

@end
