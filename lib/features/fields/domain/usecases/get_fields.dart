import '../entities/field.dart';
import '../repositories/fields_repository.dart';

class GetFields {
  final FieldsRepository repository;
  GetFields(this.repository);

  Future<List<Field>> call() => repository.getFields();
}
