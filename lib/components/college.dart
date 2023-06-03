class College {
  final int id;
  final String name;

  College({required this.id, required this.name});

  factory College.fromJson(Map<String, dynamic> json) {
    return College(
      id: json['collageId'] as int,
      name: json['name'] as String,
    );
  }
}
