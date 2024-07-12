import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class NavigatorUtil {
  static Future<dynamic> push(BuildContext context, Widget child) {
    return _pushRightToLeftWithFade(context, child: child);
  }

  static Future<dynamic> pushReplacement(BuildContext context, Widget child) {
    return _pushRightToLeftWithFadeReplace(context, child: child);
  }

  static Future<dynamic> _pushRightToLeftWithFade(BuildContext context,
      {required Widget child, bool onlySwipeFromEdge = true}) {
    return _pushWithCustomFade(context,
        child: child, onlySwipeFromEdge: onlySwipeFromEdge);
  }

  static Future<dynamic> _pushRightToLeftWithFadeReplace(BuildContext context,
      {required Widget child, bool onlySwipeFromEdge = true}) {
    return _pushWithCustomFadeReplace(context,
        child: child, onlySwipeFromEdge: onlySwipeFromEdge);
  }

  static Future<dynamic> pushBottomToTop(BuildContext context, Widget child) {
    return Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        alignment: Alignment.topCenter,
        child: child,
        settings: RouteSettings(name: child.runtimeType.toString()),
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  static Future<dynamic> _pushWithCustomFade(BuildContext context,
      {required Widget child, bool onlySwipeFromEdge = false}) {
    return Navigator.push(
        context,
        SwipeablePageRoute(
          canOnlySwipeFromEdge: onlySwipeFromEdge,
          builder: (context) => child,
          settings: RouteSettings(name: child.runtimeType.toString()),
        ));
  }

  static Future<dynamic> _pushWithCustomFadeReplace(BuildContext context,
      {required Widget child, bool onlySwipeFromEdge = false}) {
    return Navigator.pushReplacement(
        context,
        SwipeablePageRoute(
          canOnlySwipeFromEdge: onlySwipeFromEdge,
          builder: (context) => child,
          settings: RouteSettings(name: child.runtimeType.toString()),
        ));
  }

  static Future<dynamic> pushAndRemoveUntilWithFade(
      BuildContext context, Widget child) {
    return Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => child,
        settings: RouteSettings(name: child.runtimeType.toString()),
      ),
      ModalRoute.withName('/'),
    );
  }

  static void popToFirstScreen(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
