import 'package:flutter/material.dart';

class LoadingDisplay extends StatefulWidget {
  @override
  State<LoadingDisplay> createState() => _LoadingDisplay();
}

class _LoadingDisplay extends State<LoadingDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);
  }

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.repeat();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            width: 300,
            height: 300,
            child: RotationTransition(
                turns: _animation,
                child: const Image(
                    image: AssetImage('assets/pokeball.png'),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    ); // ...
  }
}
