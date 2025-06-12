

class Product {
  final String id;
  final String name;
  final String? description;
  final double price;
  final String image; // Keep this for emoji fallback
  final String imageUrl; // Add this new field
  final String category;
  final String unit;
  final bool isOrganic;
  final double rating;
  final int reviews;
  final List<String> tags;

  Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.image,
    required this.imageUrl, // Add this parameter
    required this.category,
    required this.unit,
    this.isOrganic = false,
    required this.rating,
    required this.reviews,
    required this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
      imageUrl: json['imageUrl'] ?? '', // Handle null case
      category: json['category'],
      unit: json['unit'],
      isOrganic: json['isOrganic'] ?? false,
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      tags: List<String>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'imageUrl': imageUrl,
      'category': category,
      'unit': unit,
      'isOrganic': isOrganic,
      'rating': rating,
      'reviews': reviews,
      'tags': tags,
    };
  }
}


