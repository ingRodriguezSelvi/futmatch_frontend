import '../../domain/entities/player.dart';

class PlayerModel extends Player {
  PlayerModel({
    required super.id,
    required super.name,
    required super.age,
    required super.positions,
    required super.avatar,
    required super.rating,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      positions: List<String>.from(json['positions'] ?? []),
      avatar: json['avatar'],
      rating: json['rating'],
    );
  }
}
