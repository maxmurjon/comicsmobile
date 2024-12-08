class Attribute {
  final int id;
  final String name;
  final String dataType;

  Attribute({
    required this.id,
    required this.name,
    required this.dataType,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'],
      name: json['name'],
      dataType: json['data_type'],
    );
  }
}
