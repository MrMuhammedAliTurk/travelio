class Destination {
  const Destination({
    required this.id,
    required this.name,
    required this.city,
    required this.region,
    required this.category,
    required this.description,
    required this.duration,
    required this.budget,
    required this.rating,
    required this.imageUrl,
    required this.tags,
    this.featured = false,
    this.country = 'Türkiye',
  });

  final String id;
  final String name;
  final String city;
  final String region;
  final String category;
  final String description;
  final String duration;
  final String budget;
  final double rating;
  final String imageUrl;
  final List<String> tags;
  final bool featured;
  final String country;

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      region: json['region'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      duration: json['duration'] as String,
      budget: json['budget'] as String,
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      tags: List<String>.from(json['tags'] as List<dynamic>),
      featured: json['featured'] as bool? ?? false,
      country: json['country'] as String? ?? 'Türkiye',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'city': city,
        'region': region,
        'category': category,
        'description': description,
        'duration': duration,
        'budget': budget,
        'rating': rating,
        'imageUrl': imageUrl,
        'tags': tags,
        'featured': featured,
        'country': country,
      };
}
