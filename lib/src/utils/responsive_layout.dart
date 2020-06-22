import 'package:flutter/material.dart';

/// The is a generic widget, used for determining the screen sizes (mobile or desktop)
/// isSmallScreen and isLargeScreen are the functions to decide the width of screen

class ResponsiveLayout extends StatelessWidget {
  /// variable to be used for desktop view
  final Widget largeScreen;

  /// variable to be used for mobile view
  final Widget smallScreen;

  const ResponsiveLayout({
    Key key,
    @required this.largeScreen,
    this.smallScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 992) {
          return largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}
