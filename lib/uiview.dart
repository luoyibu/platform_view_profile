import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UIView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return UiKitView(
      viewType: 'uiview',
      onPlatformViewCreated: null,
      creationParams: null,
      creationParamsCodec: StandardMessageCodec(),
    );
  }
}