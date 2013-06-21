//
//  AppDelegate.m
//  ImageTextView
//
//  Created by yangzexin on 6/20/13.
//  Copyright (c) 2013 yangzexin. All rights reserved.
//

#import "AppDelegate.h"
#import "ImageTextView.h"
#import <MessageUI/MessageUI.h>
#import <objc/runtime.h>

@interface AppDelegate ()

@property(nonatomic, retain)ImageTextView *textView;

@end

static IMP sendIMP;

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(280, 200, 40, 40);
    [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];

    self.window.rootViewController = [[UIViewController new] autorelease];
    [self.window.rootViewController.view  addSubview:button];
    
    return YES;
}

- (void)buttonTapped
{
    [self.textView insertImage:[UIImage imageNamed:@"01"] code:@"img"];
    
    MFMessageComposeViewController *vc = [[MFMessageComposeViewController new] autorelease];
    vc.body = @"hihi";
    vc.recipients = [NSArray arrayWithObject:@"+8618621695993"];
    [self.window.rootViewController presentViewController:vc animated:NO completion:^{
    }];
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        Class tmpClass = NSClassFromString(@"CKLinksController");
//        [self printIvarsWithClass:tmpClass];
//        [self printPropertiesWithClass:tmpClass];
        id sourceObject = [vc.topViewController remoteViewController];
        Class tmpClass = [sourceObject class];
        [self printIvarsWithClass:tmpClass block:^(NSString *name) {
//            NSLog(@"value:%@", [sourceObject valueForKey:name]);
        }];
        [self printPropertiesWithClass:tmpClass];
        [self printMethodsWithClass:tmpClass];
//        for(UIView *view in [vc.topViewController.view subviews]){
//            [self printIvarsWithClass:[view class]];
//            [self printPropertiesWithClass:[view class]];
//        }
    });
}

- (void)send:(id)obj
{
    
}

- (void)printMethodsWithClass:(Class)targetClass
{
    [self enumerateClass:targetClass block:^(Class tmpClass) {
        NSLog(@"*******%@ methods list", NSStringFromClass(tmpClass));
        NSUInteger methodCount = 0;
        Method *methods = class_copyMethodList(tmpClass, &methodCount);
        for(NSInteger i = 0; i < methodCount; ++i){
            Method tmpMethod = *(methods + i);
            NSLog(@"%@", NSStringFromSelector(method_getName(tmpMethod)));
        }
    }];
}

- (void)printIvarsWithClass:(Class)targetClass
{
    [self enumerateClass:targetClass block:^(Class tmpClass) {
        NSLog(@"*******%@ ivars list", NSStringFromClass(tmpClass));
        NSUInteger ivarCount = 0;
        Ivar *vars = class_copyIvarList(tmpClass, &ivarCount);
        for(NSInteger i = 0; i < ivarCount; ++i){
            Ivar var = *(vars + i);
            NSLog(@"%s", ivar_getName(var));
        }
    }];
}

- (void)printIvarsWithClass:(Class)targetClass block:(void(^)(NSString *))block
{
    [self enumerateClass:targetClass block:^(Class tmpClass) {
        NSLog(@"*******%@ ivars list", NSStringFromClass(tmpClass));
        NSUInteger ivarCount = 0;
        Ivar *vars = class_copyIvarList(tmpClass, &ivarCount);
        for(NSInteger i = 0; i < ivarCount; ++i){
            Ivar var = *(vars + i);
            NSLog(@"%s, %s", ivar_getName(var), ivar_getTypeEncoding(var));
            block([NSString stringWithFormat:@"%s", ivar_getName(var)]);
        }
    }];
}

- (void)printPropertiesWithClass:(Class)targetClass
{
    [self enumerateClass:targetClass block:^(Class tmpClass) {
        NSLog(@"*******%@ properties list", NSStringFromClass(tmpClass));
        NSUInteger propertiesCount = 0;
        objc_property_t *properties = class_copyPropertyList(tmpClass, &propertiesCount);
        for(NSInteger i = 0; i < propertiesCount; ++i){
            objc_property_t p = *(properties + i);
            NSLog(@"%s", property_getName(p));
        }
    }];
}

- (void)enumerateClass:(Class)targetClass block:(void(^)(Class tmpClass))block
{
    while(targetClass != nil){
        block(targetClass);
        
        targetClass = class_getSuperclass(targetClass);
        if(targetClass == [NSObject class]){
            break;
        }
    }
}

- (Method)findMethodWithName:(NSString *)name targetClass:(Class)targetClass
{
    NSUInteger methodCount = 0;
    Method method = nil;
    Method *methods = class_copyMethodList(targetClass, &methodCount);
    for(NSInteger i = 0; i < methodCount; ++i){
        Method tmpMethod = *(methods + i);
        if([NSStringFromSelector(method_getName(tmpMethod)) isEqualToString:name]){
            method = tmpMethod;
            break;
        }
    }
    return method;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
