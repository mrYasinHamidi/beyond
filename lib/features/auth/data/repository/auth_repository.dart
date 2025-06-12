import 'package:beyond/core/errors/failure.dart';
import 'package:beyond/core/repository/repository.dart';
import 'package:beyond/features/auth/data/data_source/auth_data_source.dart';
import 'package:beyond/features/auth/domain/entities/country/country.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthRepository extends Repository {
  final AuthDataSource _dataSource;

  AuthRepository({required AuthDataSource dataSource}) : _dataSource = dataSource;

  Future<Either<Failure, List<Country>>> getCountries() => perform(() => _dataSource.getCountries());
}
