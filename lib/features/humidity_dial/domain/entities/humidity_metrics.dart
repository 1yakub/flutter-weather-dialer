class HumidityMetrics {
  final double currentHumidity;
  final double averageHumidity;
  final double temperature;
  final int batteryLife;
  final List<String> impactIncidents;
  final DateTime lastUpdated;

  const HumidityMetrics({
    required this.currentHumidity,
    required this.averageHumidity,
    required this.temperature,
    required this.batteryLife,
    required this.impactIncidents,
    required this.lastUpdated,
  });
} 