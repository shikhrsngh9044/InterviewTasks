import 'package:flutter/material.dart';

class AnimatedSwitch extends StatefulWidget {
  const AnimatedSwitch({Key? key}) : super(key: key);

  @override
  State<AnimatedSwitch> createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: _switchValue ? const Color(0xFF3A7098) : const Color(0xFFA3D2EF),
        child: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _switchValue = !_switchValue;
              });
            },
            child: AnimatedContainer(
              height: 40.0,
              width: 90.0,
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: _switchValue
                    ? const Color(0xFF1C4D76)
                    : const Color(0xFF3A7098),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedPositioned(
                    left: _switchValue ? 55.0 : 10.0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      height: 25.0,
                      width: 25.0,
                      alignment: Alignment.centerLeft,
                      // margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _switchValue
                            ? Colors.yellow[300]
                            : Colors.yellow[600],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4.0,
                    right: 18.0,
                    child: AnimatedContainer(
                      height: _switchValue ? 25.0 : 10.0,
                      width: _switchValue ? 25.0 : 10.0,
                      duration: const Duration(milliseconds: 500),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _switchValue
                            ? const Color(0xFF1C4D76)
                            : const Color(0xFF3A7098),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
