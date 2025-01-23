/// Entity class representing humidity-related metrics and associated sensor data.
/// This class holds all the data needed to display the humidity dial and related information.
///
/// Key metrics:
/// - Current humidity level
/// - 72-hour average humidity
/// - Current temperature
/// - Device battery life
/// - Impact incident history
///
/// To extend this for other metrics:
/// 1. Add new fields for your specific metrics
/// 2. Update the constructor parameters
/// 3. Consider adding validation or data processing methods
class HumidityMetrics {
  /// The current humidity reading as a percentage (0-100)
  final double currentHumidity;

  /// The 72-hour average humidity as a percentage (0-100)
  final double averageHumidity;

  /// The current temperature reading in Fahrenheit
  final double temperature;

  /// The device's battery life percentage (0-100)
  final int batteryLife;

  /// List of recorded impact incidents with timestamps or descriptions
  final List<String> impactIncidents;

  /// Timestamp of the last data update
  final DateTime lastUpdated;

  /// Creates a new instance of [HumidityMetrics] with the required data.
  ///
  /// All parameters are required to ensure complete data representation:
  /// - [currentHumidity]: Latest humidity reading
  /// - [averageHumidity]: 72-hour average humidity
  /// - [temperature]: Current temperature
  /// - [batteryLife]: Device battery percentage
  /// - [impactIncidents]: List of recorded incidents
  /// - [lastUpdated]: Timestamp of the last update
  const HumidityMetrics({
    required this.currentHumidity,
    required this.averageHumidity,
    required this.temperature,
    required this.batteryLife,
    required this.impactIncidents,
    required this.lastUpdated,
  });
}
