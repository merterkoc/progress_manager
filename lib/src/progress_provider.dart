import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:progress_manager/src/progress.dart';

class ListenProgress {
  StreamSubscription<int>? _subscription;
  late BuildContext context;

  void subscribeToProgress(
    LoaderProvider progressProvider,
    BuildContext context,
  ) {
    _subscription = progressProvider.stream.listen((count) {
      if (count == 1) {
        context.loaderOverlay.show();
      } else if (count == 0) {
        context.loaderOverlay.hide();
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
