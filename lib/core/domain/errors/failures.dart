import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/config/l10n/localization.dart';

abstract class Failure {
  final Exception? exception;

  Failure(this.exception);

  String messageOf(BuildContext context);
}

class SocketFailure extends Failure {
  SocketFailure(super.exception);

  @override
  String messageOf(BuildContext context) => context.l10n.noInternetConnection;
}

class ServerFailure extends Failure {
  ServerFailure(super.exception);

  @override
  String messageOf(BuildContext context) => context.l10n.serverError;
}

class NotFoundFailure extends Failure {
  NotFoundFailure(super.exception);

  @override
  String messageOf(BuildContext context) => context.l10n.notFoundError;
}

class BadRequestFailure extends Failure {
  BadRequestFailure(super.exception);

  @override
  String messageOf(BuildContext context) => context.l10n.badRequestError;
}

class NotAuthorizedFailure extends Failure {
  NotAuthorizedFailure(super.exception);

  @override
  String messageOf(BuildContext context) => context.l10n.notAuthorizedError;
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure(super.exception);

  @override
  String messageOf(BuildContext context) => context.l10n.forbiddenError;
}

class UnknownFailure extends Failure {
  UnknownFailure(super.exception);

  @override
  String messageOf(BuildContext context) => context.l10n.unknownError;
}

class TypeFailure extends Failure {
  TypeFailure() : super(null);

  @override
  String messageOf(BuildContext context) => context.l10n.typeError;
}
