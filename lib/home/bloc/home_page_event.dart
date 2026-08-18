import 'package:equatable/equatable.dart';

class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object?> get props => [];
}

class SearchEvent extends HomePageEvent {
  const SearchEvent({required this.categoria});

  final String categoria;

  @override
  List<Object?> get props => [categoria];
}
