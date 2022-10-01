import 'package:components/ignore______ui_components/rectangular_progress.dart/rectangular_painter.dart';
import 'package:flutter/material.dart';

const double _kMinRectangularProgressIndicatorSize = 36.0;
const int _kIndeterminateCircularDuration = 1333 * 2222;

class RectangularProgressIndicator extends ProgressIndicator {
  /// Creates a circular progress indicator.
  ///
  /// {@macro flutter.material.ProgressIndicator.ProgressIndicator}
  const RectangularProgressIndicator({
    Key? key,
    double? value,
    Color? backgroundColor,
    Color? color,
    Animation<Color?>? valueColor,
    this.strokeWidth = 4.0,
    String? semanticsLabel,
    String? semanticsValue,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          color: color,
          valueColor: valueColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

  /// {@template flutter.material.RectangularProgressIndicator.trackColor}
  /// Color of the circular track being filled by the circular indicator.
  ///
  /// If [RectangularProgressIndicator.backgroundColor] is null then the
  /// ambient [ProgressIndicatorThemeData.circularTrackColor] will be used.
  /// If that is null, then the track will not be painted.
  /// {@endtemplate}
  @override
  Color? get backgroundColor => super.backgroundColor;

  /// The width of the line used to draw the circle.
  final double strokeWidth;

  @override
  State<RectangularProgressIndicator> createState() =>
      _RectangularProgressIndicatorState();
}

class _RectangularProgressIndicatorState
    extends State<RectangularProgressIndicator>
    with SingleTickerProviderStateMixin {
  static const int _pathCount = _kIndeterminateCircularDuration ~/ 1333;
  static const int _rotationCount = _kIndeterminateCircularDuration ~/ 2222;

  static final Animatable<double> _strokeHeadTween = CurveTween(
    curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(
    curve: const SawTooth(_pathCount),
  ));
  static final Animatable<double> _strokeTailTween = CurveTween(
    curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(
    curve: const SawTooth(_pathCount),
  ));
  static final Animatable<double> _offsetTween =
      CurveTween(curve: const SawTooth(_pathCount));
  static final Animatable<double> _rotationTween =
      CurveTween(curve: const SawTooth(_rotationCount));

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateCircularDuration),
      reverseDuration: const Duration(milliseconds: 6000),
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("called completd");
          _controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          print("called dismissed");
          _controller.repeat();
        }
      });
    if (widget.value == null) _controller.repeat();
  }

  @override
  void didUpdateWidget(RectangularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating) {
      print("called1");
      _controller.repeat();
    } else if (widget.value != null && _controller.isAnimating) {
      print("called2");
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMaterialIndicator(
    BuildContext context,
    double headValue,
    double tailValue,
    double offsetValue,
    double rotationValue,
  ) {
    final Color? trackColor = widget.backgroundColor ??
        ProgressIndicatorTheme.of(context).circularTrackColor;

    return Container(
      constraints: const BoxConstraints(
        minWidth: _kMinRectangularProgressIndicatorSize,
        minHeight: _kMinRectangularProgressIndicatorSize,
      ),
      child: CustomPaint(
        painter: RectangularProgressIndicatorPainter(
          backgroundColor: trackColor,
          valueColor: widget.valueColor?.value ?? Colors.blue,
          value: widget.value, // may be null
          headValue:
              headValue, // remaining arguments are ignored if widget.value is not null
          tailValue: tailValue,
          offsetValue: offsetValue,
          rotationValue: rotationValue,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }

  Widget _buildAnimation() {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceIn,
        reverseCurve: Curves.bounceInOut,
      ),
      builder: (BuildContext context, Widget? child) {
        return _buildMaterialIndicator(
          context,
          _strokeHeadTween.evaluate(_controller),
          _strokeTailTween.evaluate(_controller),
          _offsetTween.evaluate(_controller),
          _rotationTween.evaluate(_controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      return _buildMaterialIndicator(context, 0.0, 0.0, 0, 0.0);
    }
    return _buildAnimation();
  }
}
