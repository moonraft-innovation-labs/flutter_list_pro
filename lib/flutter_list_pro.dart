library flutter_list_pro;

import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'responsive_layout.dart';

/// Enables Carousel scroll features for listView in web
/// Uses [ScrollController] API to enable the carousel scroll feature for listView in web 
/// Required arguments - child, scrollThreshold
/// child Argument - Widget where the scroll feature will be added
/// scrollThreshold - Amount of scroll happens on single press
/// ```dart
/// ScrollHandler(
///   child: WidgetToWhichScrollToBeApplied(),
///   scrollController: <scrollController_reference>,
///   scrollThreshold: <integer_value_of_a_single_scroll>
/// )
/// ```
class ScrollHandler extends StatefulWidget {
  /// Child Widget for which the Scroll to be applied
  final Widget child;

  /// Amount of scroll happens on single press
  final int scrollThreshold;

  /// ScrollController reference for the child to scroll. Required field to be passed from the parent widget.
  /// Since [scrollController] is attached to child widget, the reference has to be passed to this component so that scorolling can be controlled.
  final ScrollController scrollController;

  const ScrollHandler({
    Key key,
    @required this.child,
    @required this.scrollController,
    this.scrollThreshold,
  }) : super(key: key);
  _ScrollHandlerState createState() => _ScrollHandlerState();
}

class _ScrollHandlerState extends State<ScrollHandler> {
  /// Distance of the current scroll
  double _scrollDistance = 0;

  /// Enables the right arrow once needed
  bool _visibleRightArrow = true;
  //// Enables the left arrow once needed
  bool _visibleLeftArrow =
      false; // Default to false to not to show the left arrow on load

  /// Animator to Slide the cards Smoothly
  void animateSlides(value) {
    widget.scrollController.animateTo(
      _scrollDistance + (value),
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 500),
    );
    setState(() {
      _scrollDistance = _scrollDistance + (value);
    });
  }

  ///handling slides animation only in web.
  ///_increment function animate slide to right using _scrollController
  void _increment() {
    if (widget.scrollController.position.atEdge) {
      if (widget.scrollController.position.pixels <= 0) {
        animateSlides(widget.scrollThreshold);
        setState(() {
          _visibleLeftArrow = true;
        });
      } else {
        setState(() {
          _visibleRightArrow = false;
        });
      }
    } else {
      animateSlides(widget.scrollThreshold);
    }
  }

  ///handling slides animation only in web.
  ///_decrement function animate slide to left using _scrollController
  void _decrement() {
    if (widget.scrollController.position.atEdge) {
      if (widget.scrollController.position.pixels > 0) {
        animateSlides(-widget.scrollThreshold);
        setState(() {
          _visibleRightArrow = true;
        });
      } else {
        setState(() {
          _visibleLeftArrow = false;
        });
      }
    } else {
      animateSlides(-widget.scrollThreshold);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
          largeScreen: Stack(
            children: <Widget>[
              widget.child,
              Positioned(
                top: 0,
                bottom: 0,
              
                width: MediaQuery.of(context).size.width+10,
                child: Container(
                  
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _visibleLeftArrow
                          ? Transform.rotate(
                              angle: 90 * math.pi / 180,
                              child: ClipOval(
                                child: Material(
                                  color: Theme.of(context).buttonColor,
                                  child: InkWell(
                                    child: Icon(Icons.arrow_drop_down, size: 35),
                                    onTap: _decrement,
                                  ),
                                ),
                              ))
                          : (Container()),
                      _visibleRightArrow
                          ? Transform.rotate(
                              angle: -90 * math.pi / 180,
                              child: ClipOval(
                                child: Material(
                                  color: Theme.of(context).buttonColor,
                                  child: InkWell(
                                    // inkwell color
                                    child: Icon(Icons.arrow_drop_down, size: 35),
                                    onTap: _increment,
                                  ),
                                ),
                              ))
                          : (Container()),
                    ],
                  ),
                ),
              ),
            ],
          ),
          smallScreen: Container(child: widget.child),
        );
  }
}

