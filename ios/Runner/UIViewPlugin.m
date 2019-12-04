//
//  UIViewPlugin.m
//  Runner
//
//  Created by jonasluo on 2019/12/3.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "UIViewPlugin.h"
#import "UIViewPluginController.h"

@implementation UIViewPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    UIViewFactory *factory = [[UIViewFactory alloc] initWithRegistrar:registrar];
    [registrar registerViewFactory:factory withId:@"uiview"];
}

@end
