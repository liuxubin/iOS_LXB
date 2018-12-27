//
//  LXB_ForwardingViewController.m
//  iOS_LXB
//
//  Created by 穗金所 on 2018/12/14.
//  Copyright © 2018年 kodbin. All rights reserved.
//

#import "LXB_ForwardingViewController.h"
#import "objc/runtime.h"
#import "UIViewController+Unit.h"

//-----------------------------------------------------
@interface Person: NSObject

@end
@implementation Person
- (void)foo {
    NSLog(@"Doing foo");//Person的foo函数
}
@end
//-----------------------------------------------------

//-----------------------------------------------------
@interface Boy: Person

@end
@implementation Boy
- (void)foo {
    [super foo];
    NSLog(@"Doing Boy");//Person的foo函数
}
@end
//-----------------------------------------------------

//----------分类-------------------------------
//分类方法会替代对象方法  但是控制器中的分类方法是在对象方法之后的  ???
@interface Person (Unit)
- (void)foo;
@end
@implementation Person (Unit)
- (void)foo{
    NSLog(@"分类方法=======");
}
@end
//----------分类-------------------------------



@interface LXB_ForwardingViewController ()

@end

@implementation LXB_ForwardingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"消息转发";
    //执行foo函数--消息转发
    [self performSelector:@selector(foo)];
    
    //测试分类调用先后
    [self makeSomeT];
    
    Person *pe = [Person new];
    [pe foo];
    
}

- (void)makeSomeT{
    NSLog(@"信息0000双打");
}

//第一步 解决该方法(对该对象添加新方法实现)
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    /*
    if (sel == @selector(foo:)) {//如果是执行foo函数，就动态解析，指定新的IMP
        class_addMethod([self class], sel, (IMP)fooMethod, "v@:");//添加方法
        return YES;
    }
    return [super resolveInstanceMethod:sel];
    */
    return NO;//返回YES，进入下一步转发
}

void fooMethod(id obj, SEL _cmd) {
    NSLog(@"Doing foo");//新的foo函数
}

//第二步 转发给其他对象实现
- (id)forwardingTargetForSelector:(SEL)aSelector {
    /*
    if (aSelector == @selector(foo)) {
        return [Person new];//返回Person对象，让Person对象接收这个消息
    }
    return [super forwardingTargetForSelector:aSelector];
    */
    return nil;//返回nil，进入下一步转发
}

//第三步 
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"foo"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];//签名，进入forwardInvocation
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    
    Person *p = [Person new];
    if([p respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:p];
    }
    else {
        [self doesNotRecognizeSelector:sel];
    }
    
}





//https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
