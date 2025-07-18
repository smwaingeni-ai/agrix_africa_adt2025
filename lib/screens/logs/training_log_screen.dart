import 'package:flutter/material.dart';

class TrainingLogScreen extends StatelessWidget {
  const TrainingLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Log'),
      ),
      body: const Center(
        child: Text('Document training sessions and attendance.'),
      ),
    );
  }
}
