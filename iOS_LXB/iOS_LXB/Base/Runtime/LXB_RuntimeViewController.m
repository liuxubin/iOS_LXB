//
//  LXB_RuntimeViewController.m
//  iOS_LXB
//
//  Created by 穗金所 on 2018/12/25.
//  Copyright © 2018年 kodbin. All rights reserved.
//

#import "LXB_RuntimeViewController.h"

//-----------------------------------------------------
@interface Animal: NSObject
@property (nonatomic,strong)NSString *age;
@end
@implementation Animal
@end
//-----------------------------------------------------

@interface LXB_RuntimeViewController ()

@property (nonatomic,strong)NSString *myName;
@property (nonatomic,assign)NSInteger myCount;

@end

@implementation LXB_RuntimeViewController
{
    NSString *ioc;//成员变量 非属性
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //https://www.jianshu.com/p/46dd81402f63
    
    unsigned int count;
    //1.获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    
    //2.获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    
    //3.获取成员变量列表(属性是成员变量,成员变量不一定是属性)
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    
    //4.获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
    
    //5.添加方法
    //Method 方法,包括SEL与IMP与type  获取某个方法 class_getInstanceMethod(Class _Nullable cls, SEL _Nonnull name)
    //SEL 方法名    @selector(fooMethod0) --或者-- method_getName(Method _Nonnull m)
    //IMP 方法实现   (IMP)fooMethod0直接是C的实现  --或者-- method_getImplementation(Method _Nonnull m)
    //type 方法类型  method_getTypeEncoding(Method _Nonnull m)
    
    Animal *ani = [Animal new];
    //class_addMethod([ani class], @selector(printPerson), (IMP)fooMethod0, "v@:");//第一种方法
    Method cusMethod = class_getInstanceMethod([self class], @selector(fooMethod0));
    class_addMethod([ani class], @selector(printPerson), method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));//第二种
    [ani performSelector:@selector(printPerson)];//执行
    
    //6.替换方法
    Method yyMethod = class_getInstanceMethod([self class], @selector(yy));
    class_replaceMethod([ani class], @selector(printPerson), method_getImplementation(yyMethod), method_getTypeEncoding(yyMethod));
    [ani performSelector:@selector(printPerson)];//执行
    
    //7.交换两个方法
    Method selfMethod1 = class_getInstanceMethod([self class], @selector(fooMethod0));
    Method selfMethod2 = class_getInstanceMethod([self class], @selector(yy));
    method_exchangeImplementations(selfMethod1, selfMethod2);
    [self yy];
    [ani performSelector:@selector(printPerson)];//执行  这里说明添加方法,或替换方法都不会被原方法实现的交换而改变 IMP地址是固定的
    
    //8.赋值
    NSLog(@"XiaoMing's age is %@",ani.age);
    Ivar *ivar = class_copyIvarList([ani class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        if ([name isEqualToString:@"_age"]) {
            object_setIvar(ani, var, @"20");
            break;
        }
    }
    NSLog(@"XiaoMing's age is %@",ani.age);
    
    
}

//void fooMethod0(id obj, SEL _cmd) {
//    NSLog(@"这是Animal新添加的方法实现");//新的foo函数
//}
- (void)fooMethod0{
    NSLog(@"这是Animal新添加的方法实现");
}



- (void)yy{
    NSLog(@"替换掉Animal的方法实现");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
