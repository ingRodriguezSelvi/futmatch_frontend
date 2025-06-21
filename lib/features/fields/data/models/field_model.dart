import '../../domain/entities/field.dart';

class FieldModel extends Field {
  FieldModel({
    required super.id,
    required super.name,
    required super.location,
    required super.courts,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      courts: json['courts'],
    );
  }
}
