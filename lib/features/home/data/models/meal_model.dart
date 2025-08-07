class Meal{
  final String name;
  final String imageUrl;
  final double rating;
  final String time;
  final String description;

  Meal({
    required this.name,
    required this.rating,
    required this.description,
    required this.time,
    required this.imageUrl,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      description: json['description'] as String ,
      time: json['time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'rating': rating,
      'time': time,
    };
  }
} 