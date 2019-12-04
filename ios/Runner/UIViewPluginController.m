//
//  UIViewPluginController.m
//  Runner
//
//  Created by jonasluo on 2019/12/3.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "UIViewPluginController.h"

@implementation UIViewPluginController
{
    UIView *_view;
}

- (instancetype)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args registrar:(NSObject<FlutterPluginRegistrar> *)registrar
{
    if (self = [super init]) {
        _view = [UIView new];
        _view.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (nonnull UIView *)view {
    return _view;
}

@end

@implementation UIViewFactory
{
    NSObject<FlutterPluginRegistrar>* _registrar;
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    if (self = [super init]) {
        _registrar = registrar;
    }
    return self;
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
  return [FlutterStandardMessageCodec sharedInstance];
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    
  return [[UIViewPluginController alloc] initWithFrame:frame
                                        viewIdentifier:viewId
                                             arguments:args
                                             registrar:_registrar];
}


@end
