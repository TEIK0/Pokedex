import 'package:flutter/material.dart';
import 'package:poke_app/core/widgets/widgets.dart';

class MessageDisplay extends StatelessWidget {
  final String message;

  const MessageDisplay({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            const ResetButtonWidget(instance: "SearchProvider"),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
