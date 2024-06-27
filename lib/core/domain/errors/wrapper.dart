import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'exceptions.dart';
import 'failures.dart';

mixin ErrorWrapper<T> {
  final _logger = Logger();

  Future<Either<Failure, T>> wrapper(Future<T> Function() execute) async {
    try {
      return Right(await execute());
    } catch (err, st) {
      _logger.w("_ErrorWrapper\n:$err", stackTrace: st);
      return _resolveLeft(err);
    }
  }

  Either<Failure, T> syncWrapper(T Function() execute) {
    try {
      return Right(execute());
    } catch (err, st) {
      _logger.w("_ErrorWrapper\n:$err", stackTrace: st);
      return _resolveLeft(err);
    }
  }

  Either<Failure, T> _resolveLeft(Object err) {
    if (err is DioException) {
      return _handleDioException(err);
    } else if (err is TypeError) {
      return Left(TypeFailure());
    } else if (err is CustomException) {
      return _handleCustomException(err);
    } else if (err is Error) {
      return Left(UnknownFailure(null));
    }

    return Left(UnknownFailure(err as Exception));
  }

  Either<Failure, T> _handleDioException(DioException err) {
    switch (err.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.cancel:
        return Left(SocketFailure(err));
      case DioExceptionType.badResponse:
        return _handleDioBadResponse(err);
      default:
        return Left(UnknownFailure(err));
    }
  }

  Either<Failure, T> _handleDioBadResponse(DioException err) {
    final statusCode = err.response?.statusCode;
    if (statusCode != null) {
      switch (statusCode) {
        case 422:
        case >= 500:
          return Left(ServerFailure(err));
        case 401:
          return Left(NotAuthorizedFailure(err));
        case 404:
          return Left(NotFoundFailure(err));
        case 400:
          return Left(BadRequestFailure(err));
        default:
          return Left(UnknownFailure(err));
      }
    }
    return Left(UnknownFailure(err));
  }

  Either<Failure, T> _handleCustomException(CustomException err) {
    switch (err) {}
  }
}
