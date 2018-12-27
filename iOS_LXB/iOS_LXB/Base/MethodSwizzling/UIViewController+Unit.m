//
//  UIViewController+Unit.m
//  iOS_LXB
//
//  Created by 穗金所 on 2018/12/17.
//  Copyright © 2018年 kodbin. All rights reserved.
//

#import "UIViewController+Unit.h"
#import "objc/runtime.h"

@implementation UIViewController (Unit)

//方法调配========================================
//load方法:当类（Class）或者类别（Category）加入Runtime中时（就是被引用的时候）实现该方法，可以在加载时做一些类特有的操作。
//一个类的+load方法在其父类的+load方法后调用 一个Category的+load方法在被其扩展的类的自有+load方法后调用
+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //Method viewDidLoad = class_get
        Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
        Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
        method_exchangeImplementations(fromMethod, toMethod);
    });
}

- (void)swizzlingViewDidLoad {
    NSString *str = [NSString stringWithFormat:@"%@", self.class];
    // 我们在这里加一个判断，将系统的UIViewController的对象剔除掉
    if(![str containsString:@"UI"]){
        NSLog(@"统计打点 : %@", self.class);
    }
    [self swizzlingViewDidLoad];//这里调用的已经是viewDidLoad的方法实现
}

//关联对象(动态添加属性)========================================
@dynamic defaultColor;
static char kDefaultColorKey;
- (void)setDefaultColor:(UIColor *)defaultColor {
    objc_setAssociatedObject(self, &kDefaultColorKey, defaultColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)defaultColor {
    return objc_getAssociatedObject(self, &kDefaultColorKey);
}



@end
