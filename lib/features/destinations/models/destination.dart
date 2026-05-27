class PriceRange {
  final int? min;
  final int? max;
  final String label;

  PriceRange({
    this.min,
    this.max,
    required this.label,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) {
    return PriceRange(
      min: json['min'] as int?,
      max: json['max'] as int?,
      label: json['label'] as String,
    );
  }
}

class DestinationSummary {
  final int id;
  final String placeId;
  final String name;
  final String slug;
  final String category;
  final String? mapCategory;
  final String city;
  final String? address;
  final double lat;
  final double lng;
  final double? rating;
  final int? userRatingCount;
  final String priceTier;
  final PriceRange priceRange;
  final List<dynamic> photos;

  DestinationSummary({
    required this.id,
    required this.placeId,
    required this.name,
    required this.slug,
    required this.category,
    this.mapCategory,
    required this.city,
    this.address,
    required this.lat,
    required this.lng,
    this.rating,
    this.userRatingCount,
    required this.priceTier,
    required this.priceRange,
    required this.photos,
  });

  factory DestinationSummary.fromJson(Map<String, dynamic> json) {
    return DestinationSummary(
      id: json['id'] as int,
      placeId: json['place_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      category: json['category'] as String,
      mapCategory: json['map_category'] as String?,
      city: json['city'] as String,
      address: json['address'] as String?,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      userRatingCount: json['user_rating_count'] as int?,
      priceTier: json['price_tier'] as String,
      priceRange: PriceRange.fromJson(json['price_range']),
      photos: json['photos'] as List<dynamic>? ?? [],
    );
  }
}

class DestinationDetail extends DestinationSummary {
  final String? description;
  final Map<String, dynamic>? openingHours;
  final String? phone;
  final String? whatsapp;
  final String? officialUrl;
  final String? aiMicrostory;
  final DateTime? cachedAt;
  final DateTime? detailFetchedAt;

  DestinationDetail({
    required super.id,
    required super.placeId,
    required super.name,
    required super.slug,
    required super.category,
    super.mapCategory,
    required super.city,
    super.address,
    required super.lat,
    required super.lng,
    super.rating,
    super.userRatingCount,
    required super.priceTier,
    required super.priceRange,
    required super.photos,
    this.description,
    this.openingHours,
    this.phone,
    this.whatsapp,
    this.officialUrl,
    this.aiMicrostory,
    this.cachedAt,
    this.detailFetchedAt,
  });

  factory DestinationDetail.fromJson(Map<String, dynamic> json) {
    return DestinationDetail(
      id: json['id'] as int,
      placeId: json['place_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      category: json['category'] as String,
      mapCategory: json['map_category'] as String?,
      city: json['city'] as String,
      address: json['address'] as String?,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      userRatingCount: json['user_rating_count'] as int?,
      priceTier: json['price_tier'] as String,
      priceRange: PriceRange.fromJson(json['price_range']),
      photos: json['photos'] as List<dynamic>? ?? [],
      description: json['description'] as String?,
      openingHours: json['opening_hours'] as Map<String, dynamic>?,
      phone: json['phone'] as String?,
      whatsapp: json['whatsapp'] as String?,
      officialUrl: json['official_url'] as String?,
      aiMicrostory: json['ai_microstory'] as String?,
      cachedAt: json['cached_at'] != null ? DateTime.parse(json['cached_at']) : null,
      detailFetchedAt: json['detail_fetched_at'] != null ? DateTime.parse(json['detail_fetched_at']) : null,
    );
  }
}

class MapPin {
  final String placeId;
  final String mapCategory;
  final String pinColor;
  final double lat;
  final double lng;

  MapPin({
    required this.placeId,
    required this.mapCategory,
    required this.pinColor,
    required this.lat,
    required this.lng,
  });

  factory MapPin.fromJson(Map<String, dynamic> json) {
    return MapPin(
      placeId: json['place_id'] as String,
      mapCategory: json['map_category'] as String,
      pinColor: json['pin_color'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }
}
