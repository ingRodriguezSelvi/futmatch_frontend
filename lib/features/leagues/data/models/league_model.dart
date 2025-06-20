import '../../domain/entities/league.dart';

class LeagueModel extends League {
  LeagueModel({
    required super.id,
    required super.name,
    required super.adminIds,
    required super.memberIds,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      id: json['id'],
      name: json['name'],
      adminIds: List<String>.from(json['adminIds'] ?? []),
      memberIds: List<String>.from(json['memberIds'] ?? []),
    );
  }
}
