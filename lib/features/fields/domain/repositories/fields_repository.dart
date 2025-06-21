import '../entities/field.dart';

abstract class FieldsRepository {
  Future<List<Field>> getFields();
}
