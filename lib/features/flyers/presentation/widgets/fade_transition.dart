import 'package:flutter/cupertino.dart';

class FadeTransitionWrapper extends StatefulWidget {
  final Widget child;

  const FadeTransitionWrapper({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _FadeTransitionWrapperState();
}

class _FadeTransitionWrapperState extends State<FadeTransitionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(microseconds: 2000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    // no animation for now
    return widget.child;
  }
}
