import 'dart:async';

import 'package:beyond/core/errors/failure.dart';
import 'package:beyond/core/use_case/use_case.dart';
import 'package:beyond/features/auth/data/repository/auth_repository.dart';
import 'package:beyond/features/auth/domain/entities/country/country.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCountries extends NoParamUseCase<List<Country>> {
  final AuthRepository _repository;

  const GetCountries({required AuthRepository repository}) : _repository = repository;

  @override
  Future<Either<Failure, List<Country>>> call() => _repository.getCountries();
}
