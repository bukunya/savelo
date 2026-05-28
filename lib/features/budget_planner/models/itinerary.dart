class ItineraryRequestData {
  final int id;
  final String origin;
  final String destinationLabel;
  final int durationDays;
  final int numPeople;
  final num budget;
  final String status;

  ItineraryRequestData({
    required this.id,
    required this.origin,
    required this.destinationLabel,
    required this.durationDays,
    required this.numPeople,
    required this.budget,
    required this.status,
  });

  factory ItineraryRequestData.fromJson(Map<String, dynamic> json) {
    return ItineraryRequestData(
      id: json['id'] as int,
      origin: json['origin'] as String? ?? "Unknown Origin",
      destinationLabel: json['destination_label'] as String? ?? "Unknown Destination",
      durationDays: json['duration_days'] as int? ?? 1,
      numPeople: json['num_people'] as int? ?? 1,
      budget: json['budget'] as num? ?? 0,
      status: json['status'] as String? ?? "pending",
    );
  }
}

class ItinerarySummaryDetails {
  final List<String> tags;
  final int ecoPoints;
  final bool isRecommended;

  ItinerarySummaryDetails({
    required this.tags,
    required this.ecoPoints,
    required this.isRecommended,
  });

  factory ItinerarySummaryDetails.fromJson(Map<String, dynamic> json) {
    return ItinerarySummaryDetails(
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      ecoPoints: json['eco_points'] as int? ?? 0,
      isRecommended: json['is_recommended'] as bool? ?? false,
    );
  }
}

class ItinerarySummary {
  final int id;
  final String variant;
  final String title;
  final num totalEstimate;
  final int budgetPercent;
  final ItinerarySummaryDetails summary;

  ItinerarySummary({
    required this.id,
    required this.variant,
    required this.title,
    required this.totalEstimate,
    required this.budgetPercent,
    required this.summary,
  });

  factory ItinerarySummary.fromJson(Map<String, dynamic> json) {
    return ItinerarySummary(
      id: json['id'] as int? ?? 0,
      variant: json['variant'] as String? ?? "hemat",
      title: json['title'] as String? ?? "Unknown Title",
      totalEstimate: json['total_estimate'] as num? ?? 0,
      budgetPercent: json['budget_percent'] as int? ?? 0,
      summary: ItinerarySummaryDetails.fromJson(json['summary'] ?? {'tags': [], 'eco_points': 0, 'is_recommended': false}),
    );
  }
}

class ItineraryGenerateData {
  final ItineraryRequestData request;
  final List<ItinerarySummary> itineraries;

  ItineraryGenerateData({
    required this.request,
    required this.itineraries,
  });

  factory ItineraryGenerateData.fromJson(Map<String, dynamic> json) {
    return ItineraryGenerateData(
      request: ItineraryRequestData.fromJson(json['request']),
      itineraries: (json['itineraries'] as List)
          .map((i) => ItinerarySummary.fromJson(i))
          .toList(),
    );
  }
}

class ItineraryLegData {
  final num distanceKm;
  final int durationMin;
  final String transportMode;

  ItineraryLegData({
    required this.distanceKm,
    required this.durationMin,
    required this.transportMode,
  });

  factory ItineraryLegData.fromJson(Map<String, dynamic> json) {
    return ItineraryLegData(
      distanceKm: json['distance_km'] as num? ?? 0,
      durationMin: json['duration_min'] as int? ?? 0,
      transportMode: json['transport_mode'] as String? ?? "unknown",
    );
  }
}

class ItineraryItemData {
  final int id;
  final String placeId;
  final String? name;
  final String? mapCategory;
  final String? category;
  final int orderIndex;
  final String visitTime;
  final num costEstimate;
  final String costLabel;
  final ItineraryLegData? legToNext;

  ItineraryItemData({
    required this.id,
    required this.placeId,
    this.name,
    this.mapCategory,
    this.category,
    required this.orderIndex,
    required this.visitTime,
    required this.costEstimate,
    required this.costLabel,
    this.legToNext,
  });

  factory ItineraryItemData.fromJson(Map<String, dynamic> json) {
    return ItineraryItemData(
      id: json['id'] as int? ?? 0,
      placeId: json['place_id'] as String? ?? "",
      name: json['name'] as String?,
      mapCategory: json['map_category'] as String?,
      category: json['category'] as String?,
      orderIndex: json['order_index'] as int? ?? 0,
      visitTime: json['visit_time'] as String? ?? "00:00",
      costEstimate: json['cost_estimate'] as num? ?? 0,
      costLabel: json['cost_label'] as String? ?? "Rp0",
      legToNext: json['leg_to_next'] != null
          ? ItineraryLegData.fromJson(json['leg_to_next'])
          : null,
    );
  }
}

class ItineraryDayData {
  final int dayNumber;
  final num estimatedCost;
  final List<ItineraryItemData> items;

  ItineraryDayData({
    required this.dayNumber,
    required this.estimatedCost,
    required this.items,
  });

  factory ItineraryDayData.fromJson(Map<String, dynamic> json) {
    return ItineraryDayData(
      dayNumber: json['day_number'] as int? ?? 1,
      estimatedCost: json['estimated_cost'] as num? ?? 0,
      items: (json['items'] as List?)
          ?.map((i) => ItineraryItemData.fromJson(i))
          .toList() ?? [],
    );
  }
}

class ItineraryDetail {
  final int id;
  final String variant;
  final String title;
  final num totalEstimate;
  final int budgetPercent;
  final ItinerarySummaryDetails summary;
  final List<ItineraryDayData> days;

  ItineraryDetail({
    required this.id,
    required this.variant,
    required this.title,
    required this.totalEstimate,
    required this.budgetPercent,
    required this.summary,
    required this.days,
  });

  factory ItineraryDetail.fromJson(Map<String, dynamic> json) {
    return ItineraryDetail(
      id: json['id'] as int? ?? 0,
      variant: json['variant'] as String? ?? "hemat",
      title: json['title'] as String? ?? "Unknown Title",
      totalEstimate: json['total_estimate'] as num? ?? 0,
      budgetPercent: json['budget_percent'] as int? ?? 0,
      summary: ItinerarySummaryDetails.fromJson(json['summary'] ?? {'tags': [], 'eco_points': 0, 'is_recommended': false}),
      days: (json['days'] as List?)
          ?.map((d) => ItineraryDayData.fromJson(d))
          .toList() ?? [],
    );
  }
}

class ItineraryDetailData {
  final ItineraryRequestData request;
  final ItineraryDetail itinerary;

  ItineraryDetailData({
    required this.request,
    required this.itinerary,
  });

  factory ItineraryDetailData.fromJson(Map<String, dynamic> json) {
    return ItineraryDetailData(
      request: ItineraryRequestData.fromJson(json['request']),
      itinerary: ItineraryDetail.fromJson(json['itinerary']),
    );
  }
}
