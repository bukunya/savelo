import 'itinerary.dart';

class TransportModeData {
  final int id;
  final String mode;
  final String label;
  final int ecoPointsRate;
  final num co2PerKm;

  TransportModeData({
    required this.id,
    required this.mode,
    required this.label,
    required this.ecoPointsRate,
    required this.co2PerKm,
  });

  factory TransportModeData.fromJson(Map<String, dynamic> json) {
    return TransportModeData(
      id: json['id'] as int,
      mode: json['mode'] as String,
      label: json['label'] as String,
      ecoPointsRate: json['eco_points_rate'] as int,
      co2PerKm: json['co2_per_km'] as num,
    );
  }
}

class CheckinDestinationPreview {
  final String name;
  final String? address;
  final int culturePoints;

  CheckinDestinationPreview({
    required this.name,
    this.address,
    required this.culturePoints,
  });

  factory CheckinDestinationPreview.fromJson(Map<String, dynamic> json) {
    return CheckinDestinationPreview(
      name: json['name'] as String,
      address: json['address'] as String?,
      culturePoints: json['culture_points'] as int,
    );
  }
}

class CheckinPreviewData {
  final CheckinDestinationPreview destination;
  final num legDistanceKm;
  final List<TransportModeData> transportModes;

  CheckinPreviewData({
    required this.destination,
    required this.legDistanceKm,
    required this.transportModes,
  });

  factory CheckinPreviewData.fromJson(Map<String, dynamic> json) {
    return CheckinPreviewData(
      destination: CheckinDestinationPreview.fromJson(json['destination']),
      legDistanceKm: json['leg_distance_km'] as num,
      transportModes: (json['transport_modes'] as List)
          .map((t) => TransportModeData.fromJson(t))
          .toList(),
    );
  }
}

class PointsEarnedData {
  final int ecoPoints;
  final int culturePoints;
  final int pathPoints;

  PointsEarnedData({
    required this.ecoPoints,
    required this.culturePoints,
    required this.pathPoints,
  });

  factory PointsEarnedData.fromJson(Map<String, dynamic> json) {
    return PointsEarnedData(
      ecoPoints: json['eco_points'] as int,
      culturePoints: json['culture_points'] as int,
      pathPoints: json['path_points'] as int,
    );
  }
}

class CheckinData {
  final ItineraryItemData item;
  final PointsEarnedData pointsEarned;
  final int userTotalPathPoints;

  CheckinData({
    required this.item,
    required this.pointsEarned,
    required this.userTotalPathPoints,
  });

  factory CheckinData.fromJson(Map<String, dynamic> json) {
    return CheckinData(
      item: ItineraryItemData.fromJson(json['item']),
      pointsEarned: PointsEarnedData.fromJson(json['points_earned']),
      userTotalPathPoints: json['user_total_path_points'] as int,
    );
  }
}
