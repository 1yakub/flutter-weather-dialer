# Flutter Weather Dialer Widget

A highly customizable circular dial widget for displaying humidity or other metrics with a modern, Material Design-inspired interface.

## Features

- 🎯 Circular progress indicator with tick marks
- 📊 72-hour average display
- ✅ Status checkmark indicator
- 🎨 Customizable colors and styling
- 📱 Responsive layout
- 🔄 State management with BLoC pattern

## Customization Guide

### 1. Core Widget Customization (`lib/features/humidity_dial/presentation/widgets/humidity_dial.dart`)

#### Modifying Display Values
```dart
HumidityDialWidget(
  averageHumidity: 45.0,  // Change this for different average value
  currentHumidity: 44.0,  // Change this for different current value
)
```

#### Styling Text and Colors
- Font sizes and styles: Modify the `GoogleFonts.roboto` parameters
- Main value color: Change `Color(0xFF3ABE51)` in the `RichText` widget
- Label colors: Update `Color(0xFF757575)` for "HUMIDITY" text
- Average label: Modify `Color.fromARGB(255, 145, 145, 145)` for "72hr Average"

### 2. Dial Painter Customization (`lib/features/humidity_dial/presentation/widgets/humidity_dial_painter.dart`)

#### Visual Elements
```dart
HumidityDialPainter({
  required this.progress,
  this.progressColor = Colors.green,      // Active elements color
  this.backgroundColor = Color(0xFFF5F5F5), // Inactive elements color
  this.strokeWidth = 10,                  // Arc thickness
  this.showCheckmark = true,              // Toggle checkmark
})
```

#### Tick Marks Configuration
- Number of ticks: Modify `static const int totalBars = 27`
- Tick dimensions: Adjust `strokeWidth = 1.5` and `inwardExtension`
- Tick colors: Change `progressColor` and `Colors.grey[300]`

#### Dial Arc Settings
- Start angle: Modify `-225 * math.pi / 180`
- Sweep angle: Adjust `270 * math.pi / 180`
- Arc radius: Change `radius` calculation

#### Checkmark Customization
- Size: Modify `checkmarkSize = radius * 0.3`
- Position: Adjust `checkmarkCenter` offset
- Appearance: Update `strokeWidth` and `color`

### 3. Adapting for Different Metrics

#### Data Model (`lib/features/humidity_dial/domain/entities/humidity_metrics.dart`)
```dart
class HumidityMetrics {
  final double currentHumidity;    // Rename for your metric
  final double averageHumidity;    // Rename for your metric
  final double temperature;        // Add/remove fields
  final int batteryLife;
  final List<String> impactIncidents;
  final DateTime lastUpdated;
}
```

#### State Management (`lib/features/humidity_dial/presentation/bloc`)

1. Update State Class (`humidity_dial_state.dart`):
```dart
@freezed
class YourMetricState with _$YourMetricState {
  const factory YourMetricState.initial() = _Initial;
  const factory YourMetricState.loading() = _Loading;
  const factory YourMetricState.loaded(YourMetrics metrics) = _Loaded;
  const factory YourMetricState.error(String message) = _Error;
}
```

2. Update Cubit (`humidity_dial_cubit.dart`):
```dart
class YourMetricCubit extends Cubit<YourMetricState> {
  void updateMetrics(YourMetrics metrics) {
    emit(YourMetricState.loaded(metrics));
  }
}
```

### 4. Page Layout Customization (`lib/features/humidity_dial/presentation/pages/humidity_dial_page.dart`)

#### Header Modifications
- Title: Change `'Little Gem'` in AppBar
- Actions: Implement `onPressed` for EDIT button
- Last updated format: Modify timestamp display format

#### Layout Adjustments
- Padding: Update `EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0)`
- Background: Change `Colors.white` and `Colors.grey[100]`
- Scroll behavior: Modify `SingleChildScrollView` settings

## Best Practices

1. **Color Management**
   - Use consistent color variables
   - Consider dark mode support
   - Maintain accessibility standards

2. **Performance**
   - Use `const` constructors where possible
   - Implement `shouldRepaint` efficiently
   - Optimize canvas drawing operations

3. **State Management**
   - Keep state updates atomic
   - Handle loading and error states
   - Implement proper error boundaries

4. **Testing**
   - Add widget tests for UI components
   - Test state management logic
   - Verify custom painting behavior

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.