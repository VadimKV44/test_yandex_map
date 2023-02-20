part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {
  SearchInitial({
    required this.pointsModel,
});
  final List<Coordinates> pointsModel;
}
