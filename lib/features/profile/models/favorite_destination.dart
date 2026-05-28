class FavoriteDestination {
  final int id;
  final String placeId;
  final String name;
  final String slug;
  final String category;
  final String city;
  final String? address;
  final double lat;
  final double lng;
  final double? rating;
  final int? userRatingCount;
  final String? priceTier;
  final String? priceRange;
  final List<dynamic> photos;

  FavoriteDestination({
    required this.id,
    required this.placeId,
    required this.name,
    required this.slug,
    required this.category,
    required this.city,
    this.address,
    required this.lat,
    required this.lng,
    this.rating,
    this.userRatingCount,
    this.priceTier,
    this.priceRange,
    required this.photos,
  });

  factory FavoriteDestination.fromJson(Map<String, dynamic> json) {
    return FavoriteDestination(
      id: json['id'] as int,
      placeId: json['place_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      category: json['category'] as String,
      city: json['city'] as String,
      address: json['address'] as String?,
      lat: double.parse(json['lat'].toString()),
      lng: double.parse(json['lng'].toString()),
      rating: json['rating'] != null ? double.parse(json['rating'].toString()) : null,
      userRatingCount: json['user_rating_count'] != null ? int.parse(json['user_rating_count'].toString()) : null,
      priceTier: json['price_tier'] as String?,
      priceRange: json['price_range'] is Map<String, dynamic> 
          ? (json['price_range'] as Map<String, dynamic>)['label'] as String?
          : json['price_range'] as String?,
      photos: json['photos'] as List<dynamic>? ?? [],
    );
  }
}
