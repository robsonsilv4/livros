import 'package:meta/meta.dart';

import 'result_status_model.dart';

class Result<T, E> {
  final T data;
  final E error;
  final ResultStatus status;

  Result({
    @required this.data,
    @required this.error,
    @required this.status,
  });

  factory Result.success(T data) {
    return Result(
      data: data,
      error: null,
      status: ResultStatus.success,
    );
  }

  factory Result.error(E error) {
    return Result(
      data: null,
      error: error,
      status: ResultStatus.error,
    );
  }

  factory Result.loading() {
    return Result(
      data: null,
      error: null,
      status: ResultStatus.loading,
    );
  }

  factory Result.idle({T data}) {
    return Result(
      data: data,
      error: null,
      status: ResultStatus.idle,
    );
  }
}
