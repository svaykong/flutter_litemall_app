import 'status.dart';

abstract class BaseApiResponse<T> {
  Status? status;
  T? data;
  String? message;
}

class ApiResponse<T> implements BaseApiResponse<T> {
  @override
  Status? status;

  @override
  T? data;

  @override
  String? message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.complete(this.data) : status = Status.COMPLETE;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return 'ApiResponse{status: $status, data: $data, message: $message}';
  }
}
