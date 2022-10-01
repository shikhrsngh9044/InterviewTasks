import 'package:flutter/material.dart';

import 'rectangular_progress.dart/rectangular_progress_indicator.dart';

class UploadingButton extends StatefulWidget {
  const UploadingButton({Key? key}) : super(key: key);

  @override
  State<UploadingButton> createState() => _UploadingButtonState();
}

class _UploadingButtonState extends State<UploadingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 100.0,
          height: 40.0,
          child: RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
            child: RectangularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).primaryColor.withOpacity(0.4),
              ),
            ),
          ),
        ),
        // Container(
        //   width: 110.0,
        //   height: 50.0,
        //   decoration: BoxDecoration(
        //     gradient: RadialGradient(
        //       colors: [
        //         Colors.white,
        //         Theme.of(context).primaryColor.withOpacity(0.3)
        //       ],
        //     ),
        //     color: Theme.of(context).primaryColor.withOpacity(0.3),
        //     borderRadius: BorderRadius.circular(19.0),
        //   ),
        // ),
        // Container(
        //   width: 100.0,
        //   height: 40.0,
        //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).primaryColor,
        //     borderRadius: BorderRadius.circular(15.0),
        //   ),
        //   child: Row(
        //     children: const [
        //       Icon(Icons.arrow_upward_rounded, color: Colors.white),
        //       Text(
        //         "Upload",
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
