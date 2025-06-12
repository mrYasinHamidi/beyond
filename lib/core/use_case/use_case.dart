import 'dart:async';

import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

abstract class BaseUseCase<Type> {
  const BaseUseCase();
}

abstract class UseCase<Type, Params> extends BaseUseCase<Type> {
  const UseCase();

  FutureOr<Either<Failure, Type>> call(Params param);
}

abstract class NoParamUseCase<Type> extends BaseUseCase<Type> {
  const NoParamUseCase();

  FutureOr<Either<Failure, Type>> call();
}
