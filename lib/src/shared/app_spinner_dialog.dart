import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:whiskers_away_app/src/styles/app_colors.dart';
import 'dart:math' as math;

import 'package:whiskers_away_app/src/styles/app_text_styles.dart';

class AppSpinnerDialog extends StatelessWidget {
  const AppSpinnerDialog({
    required this.request,
    required this.completer,
  });
  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Column(children: [
                Loader(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Please Wait....",
                  style: AppTextStyles.xMedium(),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) {
          return Center(
            child: Transform.rotate(
              angle: _controller.status == AnimationStatus.forward
                  ? (math.pi * 2) * _controller.value
                  : -(math.pi * 2) * _controller.value,
              child: Container(
                height: 36.0,
                width: 36.0,
                child: CustomPaint(
                  painter: LoaderCanvas(radius: _animation.value),
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LoaderCanvas extends CustomPainter {
  double radius;
  LoaderCanvas({required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _arc = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    Paint _circle = Paint()
      ..color = AppColors.primaryLightColor
      ..style = PaintingStyle.fill;

    Offset _center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(_center, size.width / 2, _circle);
    canvas.drawArc(
        Rect.fromCenter(
            center: _center,
            width: size.width * radius,
            height: size.height * radius),
        math.pi / 4,
        math.pi / 2,
        false,
        _arc);
    canvas.drawArc(
        Rect.fromCenter(
            center: _center,
            width: size.width * radius,
            height: size.height * radius),
        -math.pi / 4,
        -math.pi / 2,
        false,
        _arc);
  }

  @override
  bool shouldRepaint(LoaderCanvas oldPaint) {
    return true;
  }
}
