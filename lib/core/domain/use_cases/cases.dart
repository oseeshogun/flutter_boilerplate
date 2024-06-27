import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate/core/domain/errors/failures.dart';
import 'package:flutter_boilerplate/core/domain/errors/wrapper.dart';

abstract class SyncUseCase<T> with ErrorWrapper<T> {
  Either<Failure, T> call() => syncWrapper(execute);

  T execute();
}

abstract class UseCase<T> with ErrorWrapper<T> {
  Future<Either<Failure, T>> call() async => await wrapper(execute);

  Future<T> execute();
}

abstract class SyncUseCaseFamily<T, R> with ErrorWrapper<T> {
  Either<Failure, T> call(R param) => syncWrapper(() => execute(param));

  T execute(R param);
}

abstract class UseCaseFamily<T, R> with ErrorWrapper<T> {
  Future<Either<Failure, T>> call(R param) async => await wrapper(() => execute(param));

  Future<T> execute(R param);
}
