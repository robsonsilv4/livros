import 'package:equatable/equatable.dart';

import 'package:livros/models/result_status_model.dart';

class Result<T, E> extends Equatable {
  factory Result.success(T data) {
    return Result._(
      data: data,
      error: null,
      status: ResultStatus.success,
    );
  }

  factory Result.error(E error) {
    return Result._(
      data: null,
      error: error,
      status: ResultStatus.error,
    );
  }

  factory Result.loading() {
    return const Result._(
      data: null,
      error: null,
      status: ResultStatus.loading,
    );
  }

  factory Result.idle({T? data}) {
    return Result._(
      data: data,
      error: null,
      status: ResultStatus.idle,
    );
  }
  const Result._({
    required this.data,
    required this.error,
    required this.status,
  });

  final T? data;
  final E? error;
  final ResultStatus status;

  @override
  List<Object?> get props => [data, error, status];
}
