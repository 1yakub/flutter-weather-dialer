import 'package:flutter/material.dart';
import '../widgets/humidity_dial.dart';

class HumidityDialPage extends StatelessWidget {
  const HumidityDialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Little Gem'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('EDIT'),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.grey[100],
              child: Center(
                child: Text(
                  'Last Updated: 01/20/25 9:35:52 pm',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  child: HumidityDialWidget(
                    currentHumidity: 44,
                    averageHumidity: 45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
