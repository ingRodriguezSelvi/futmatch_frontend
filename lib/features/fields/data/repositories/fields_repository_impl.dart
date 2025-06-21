import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../../domain/entities/field.dart';
import '../../domain/repositories/fields_repository.dart';
import '../datasources/fields_remote_datasource.dart';

class FieldsRepositoryImpl implements FieldsRepository {
  final FieldsRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  FieldsRepositoryImpl(this.remoteDataSource, this.localDataSource);

  Future<String> _getToken() async {
    final tokens = await localDataSource.getTokens();
    if (tokens == null) throw Exception('Usuario no autenticado');
    return tokens.accessToken;
  }

  @override
  Future<List<Field>> getFields() async {
    final token = await _getToken();
    return remoteDataSource.getFields(token);
  }
}
