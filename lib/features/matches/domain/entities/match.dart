class Match {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final DateTime date;
  final String location;
  final int? homeScore;
  final int? awayScore;

  Match({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.date,
    required this.location,
    this.homeScore,
    this.awayScore,
  });
}
