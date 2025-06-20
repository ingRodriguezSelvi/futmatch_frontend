class League {
  final String id;
  final String name;
  final List<String> adminIds;
  final List<String> memberIds;

  League({
    required this.id,
    required this.name,
    required this.adminIds,
    required this.memberIds,
  });
}
