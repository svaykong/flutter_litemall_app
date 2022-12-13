import 'package:flutter/material.dart';

@immutable
abstract class AppException implements Exception {
  final String? _prefix;
  final String? _message;

  const AppException(this._prefix, this._message);

  @override
  String toString() {
    return 'AppException{_prefix: $_prefix, _message: $_message}';
  }
}

class FetchDataException extends AppException {
  const FetchDataException(String? message) : super(message, 'error during communication');
}

class BadRequestException extends AppException {
  const BadRequestException(String? message) : super(message, 'bad request');
}

class UnAuthorizedException extends AppException {
  const UnAuthorizedException(String? message) : super(message, 'unauthorized request');
}
