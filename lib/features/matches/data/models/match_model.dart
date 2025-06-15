import '../../domain/entities/match.dart';

class MatchModel extends Match {
  MatchModel({
    required super.id,
    required super.homeTeam,
    required super.awayTeam,
    required super.date,
    required super.location,
    super.homeScore,
    super.awayScore,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'],
      homeTeam: json['homeTeam'],
      awayTeam: json['awayTeam'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      homeScore: json['homeScore'],
      awayScore: json['awayScore'],
    );
  }
}
