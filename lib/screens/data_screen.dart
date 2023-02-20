import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_map/cubits/search_cubit/search_cubit.dart';
import 'package:test_map/widgets/data_item.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> with AutomaticKeepAliveClientMixin<DataScreen> {

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return state is SearchInitial
              ? ListView.builder(
                  itemCount: state.pointsModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DataItem(
                      name: state.pointsModel[index].name,
                      latlng: 'lng: ${state.pointsModel[index].lng}; lat: ${state.pointsModel[index].lat}',
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
