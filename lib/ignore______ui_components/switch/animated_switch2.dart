import 'package:flutter/material.dart';

class AnimatedSwitch2 extends StatefulWidget {
  const AnimatedSwitch2({Key? key}) : super(key: key);

  @override
  State<AnimatedSwitch2> createState() => _AnimatedSwitch2State();
}

class _AnimatedSwitch2State extends State<AnimatedSwitch2> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _switchValue = !_switchValue;
            });
          },
          child: AnimatedContainer(
            height: 40.0,
            width: 80.0,
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              color: _switchValue
                  ? const Color.fromARGB(255, 26, 233, 116)
                  : const Color(0xFFFF1015),
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: (_switchValue
                          ? const Color.fromARGB(255, 26, 233, 116)
                          : const Color(0xFFFF1015))
                      .withOpacity(0.4),
                  offset: const Offset(2, 6),
                  blurRadius: 15.5,
                  spreadRadius: 5.5,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  left: _switchValue ? 65.0 : 10.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  child: AnimatedContainer(
                    height: 25.0,
                    width: _switchValue ? 10.0 : 25.0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.bounceInOut,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: _switchValue
                          ? const BorderRadius.vertical(
                              top: Radius.elliptical(10, 10),
                              bottom: Radius.elliptical(10, 10),
                            )
                          : BorderRadius.circular(20.0),
                    ),
                    transform: _switchValue
                        ? Matrix4.rotationY(2.7)
                        : Matrix4.rotationY(0),
                    child: AnimatedContainer(
                      height: _switchValue ? 0.0 : 16.0,
                      width: _switchValue ? 0.0 : 16.0,
                      curve: Curves.easeInOutQuint,
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _switchValue
                            ? const Color.fromARGB(255, 26, 233, 116)
                            : const Color(0xFFFF1015),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
