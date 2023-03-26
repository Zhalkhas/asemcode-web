import 'package:flutter/foundation.dart';
import 'package:qlevar_router/qlevar_router.dart';

class DeferredLoader extends QMiddleware {
  final Future<dynamic> Function() loader;
  final Future<void> Function()? onLoadFinished;
  DeferredLoader(this.loader, {this.onLoadFinished});

  @override
  Future onEnter() async {
    await loader();
    if (kDebugMode) print('deferred page loaded');
    await onLoadFinished?.call();
  }
}
