class Department {
  final int id;
  final String name;
  final String collegeName;

  Department({
    required this.id,
    required this.name,
    required this.collegeName,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['departmentId'],
      name: json['name'],
      collegeName: json['collageName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'collegeName': collegeName,
      };
}
