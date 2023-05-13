import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'progress_provider.dart';

class ProgressManager extends StatelessWidget {
  /// The widget of the overlay. This is great if you want to insert your own widget to serve as
  /// an overlay.
  final Widget? overlayWidget;

  /// Whether or not to use a default loading if none is provided.
  final bool? useDefaultLoading;

  /// The opacity of the overlay
  final double? overlayOpacity;

  /// The color of the overlay
  final Color? overlayColor;

  /// Whether or not to disable the back button while loading.
  final bool? disableBackButton;

  //Hide the loader when back button pressed
  final bool? closeOnBackButton;

  /// This should be false if you want to have full control of the size of the overlay.
  /// This is generaly used in conjunction with [overlayHeight] and [overlayWidth] to
  /// define the desired size of the overlay.
  final bool? overlayWholeScreen;

  /// The desired height of the overlay
  final double? overlayHeight;

  /// The desired width of the overlay
  final double? overlayWidth;

  /// The child that will have the overlay upon
  final Widget child;

  /// The duration when the overlay enters
  final Duration? duration;

  /// The duration when the overlay exits
  final Duration? reverseDuration;

  /// The curve for the overlay to transition in
  final Curve? switchInCurve;

  /// The curve for the overlay to transition out
  final Curve? switchOutCurve;

  /// The transition builder for the overlay
  final Widget? Function(Widget, Animation<double>)? transitionBuilder;

  /// The layout builder for the overlay
  final Widget Function(Widget?, List<Widget>) layoutBuilder;

  static const _prefix = '@loader-overlay';

  static const defaultOverlayWidgetKey = Key('$_prefix/default-widget');

  static const opacityWidgetKey = Key('$_prefix/opacity-widget');

  static const defaultOpacityValue = 0.4;

  static const defaultOverlayColor = Colors.grey;

  static const containerForOverlayColorKey =
      Key('$_prefix/container-for-overlay-color');

  static const useDefaultLoadingValue = true;

  const ProgressManager(
      {Key? key,
      required this.child,
      this.overlayWidget,
      this.useDefaultLoading,
      this.overlayOpacity,
      this.overlayColor,
      this.disableBackButton,
      this.closeOnBackButton,
      this.overlayWholeScreen,
      this.overlayHeight,
      this.overlayWidth,
      this.duration,
      this.reverseDuration,
      this.switchInCurve,
      this.switchOutCurve,
      this.transitionBuilder,
      this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressProvider = LoaderProvider();
    final observer = ListenProgress();
    observer.subscribeToProgress(
      progressProvider,
      context,
    );
    return LoaderOverlay(
      closeOnBackButton: false,
      overlayWholeScreen: false,
      child: child,
      overlayWidget: overlayWidget,
      disableBackButton: disableBackButton ?? true,
      duration: duration ?? Duration.zero,
      reverseDuration: reverseDuration,
      overlayColor: overlayColor ?? defaultOverlayColor,
      overlayOpacity: overlayOpacity ?? defaultOpacityValue,
      overlayHeight: overlayHeight,
      overlayWidth: overlayWidth,
      switchInCurve: switchInCurve ?? Curves.linear,
      switchOutCurve: switchOutCurve ?? Curves.linear,
      transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
      useDefaultLoading: useDefaultLoading ?? useDefaultLoadingValue,
      layoutBuilder: layoutBuilder,
    );
  }
}

class LoaderProvider {
  int _count = 0;

  factory LoaderProvider() => _instance;

  LoaderProvider._internal();

  static final LoaderProvider _instance = LoaderProvider._internal();

  final _streamController = StreamController<int>.broadcast();

  Stream<int> get stream => _streamController.stream;

  int get count => _count;

  void increment() {
    _count++;
    if (_count == 1) {
      _streamController.add(_count);
    }
  }

  void decrement() {
    _count--;
    if (_count == 0) {
      _streamController.add(_count);
    }
  }

  dispose() {
    _streamController.close();
  }
}
