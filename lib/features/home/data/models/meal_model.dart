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

// factory Meal.fromJson(Map<String, dynamic> json) {
//   return Meal(
//     name: json['name'] is String ? json['name'] as String : '',
//     imageUrl: json['imageUrl'] is String ? json['imageUrl'] as String : '',
//     rating: json['rating'] is num ? (json['rating'] as num).toDouble() : 0.0,
//     description: json['description'] is String ? json['description'] as String : '',
//     time: json['time'] is String ? json['time'] as String : '',
//   );
// }
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
      'description': description
    };
  }
} 