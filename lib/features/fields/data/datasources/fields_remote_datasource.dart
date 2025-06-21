import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/field_model.dart';

abstract class FieldsRemoteDataSource {
  Future<List<FieldModel>> getFields(String token);
}

class FieldsRemoteDataSourceImpl implements FieldsRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  FieldsRemoteDataSourceImpl({required this.client, required this.baseUrl});

  @override
  Future<List<FieldModel>> getFields(String token) async {
    final url = Uri.parse('$baseUrl/fields');
    final response = await client.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode != 200) {
      throw Exception('Error al obtener canchas: ${response.body}');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data.map((e) => FieldModel.fromJson(e)).toList();
  }
}
