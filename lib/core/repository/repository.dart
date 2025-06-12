import 'package:beyond/main.dart';
import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

abstract class Repository {
  const Repository();

  Future<Either<Failure, T>> perform<T>(Future<T> Function() func) async {
    try {
      return Right(await func());
    } catch (e, s) {
      return Left(_handleError(e, s));
    }
  }

  Either<Failure, T> performSync<T>(T Function() func) {
    try {
      return Right(func());
    } catch (e, s) {
      return Left(_handleError(e, s));
    }
  }

  Failure _handleError(e, s) {
    String? message;
    // if (e is DioException) {
    //   if (e.response?.data is Map) {
    //     message = e.response?.data?['message']?.toString();
    //   }
    // }
    errorPipeline.dispatch(e, s, tag: 'handled');
    return Failure(message ?? 'serverError');
  }
}
