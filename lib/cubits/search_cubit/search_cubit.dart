import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_map/data_models/points_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {

  SearchCubit({
    required this.model,
}) : super(SearchInitial(pointsModel: model.list));

  final PointsModel model;

  List<Coordinates> filterList = [];

  void searchInDataScreen(String request) {
    filterList = model.list.where((Coordinates coordinates) {
      return coordinates.name.toLowerCase().contains(request.toLowerCase());
    }).toList();
    emit(SearchInitial(pointsModel: filterList));
  }
}
