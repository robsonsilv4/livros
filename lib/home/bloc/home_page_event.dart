import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class HomePageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchEvent extends HomePageEvent {
  final String categoria;

  SearchEvent({@required this.categoria});
}
