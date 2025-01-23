/// Main page widget that displays the humidity dial and related information.
/// This page provides a complete view of humidity metrics with navigation and editing capabilities.
///
/// Features:
/// - App bar with back navigation and edit button
/// - Last updated timestamp display
/// - Scrollable container for the humidity dial
/// - Clean, modern Material Design layout
///
/// To customize this page:
/// 1. Update the app bar title and actions
/// 2. Modify the layout and styling
/// 3. Add additional widgets or functionality
/// 4. Implement the edit button functionality
import 'package:flutter/material.dart';
import '../widgets/humidity_dial.dart';

/// A stateless widget that serves as the main page for displaying the humidity dial.
/// This page follows Material Design guidelines and provides a clean user interface.
class HumidityDialPage extends StatelessWidget {
  /// Creates a new instance of [HumidityDialPage].
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
            onPressed: () {
              // TODO: Implement edit functionality
              // This could open a dialog or navigate to an edit page
            },
            child: const Text('EDIT'),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Last updated timestamp banner
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
            // Main content area with humidity dial
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
