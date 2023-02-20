import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_map/cubits/search_cubit/search_cubit.dart';
import 'package:test_map/data_models/points_model.dart';
import 'package:test_map/widgets/map_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with AutomaticKeepAliveClientMixin<MapScreen> {
  final Completer<YandexMapController> _controller = Completer<YandexMapController>();
  final animation = const MapAnimation(type: MapAnimationType.smooth, duration: 1.0);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) => context.read<SearchCubit>().searchInDataScreen(''));
  }

  @override
  void dispose() async {
    super.dispose();
    final controller = await _controller.future;
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchInitial) {

          double? latitudeMax;
          double? longitudeMax;

          double? latitudeMin;
          double? longitudeMin;

          pointsList.clear();

          if (state.pointsModel.isNotEmpty) {
            for (Coordinates point in state.pointsModel) {
              pointsList.add(
                PlacemarkMapObject(
                  mapId: MapObjectId(point.name.toString()),
                  point: Point(
                    latitude: point.lat,
                    longitude: point.lng,
                  ),
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage('assets/images/marker.png'),
                      scale: 1,
                      anchor: const Offset(0.0, 0.0),
                    ),
                  ),
                ),
              );

              latitudeMax = max(latitudeMax ?? point.lat, point.lat);
              longitudeMax = max(longitudeMax ?? point.lng, point.lng);
              latitudeMin = min(latitudeMin ?? point.lat, point.lat);
              longitudeMin = min(longitudeMin ?? point.lng, point.lng);
            }
            var newBounds = BoundingBox(
              northEast: Point(latitude: latitudeMax! + 0.5, longitude: longitudeMax! + 0.5), // max max
              southWest: Point(latitude: latitudeMin! - 1.5, longitude: longitudeMin! - 0.5), // min min
            );
            _controller.future.then((value) {
              value.moveCamera(CameraUpdate.newBounds(newBounds), animation: animation);
            });
          }
        }
      },
      builder: (context, state) {
        return ColoredBox(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: YandexMap(
                    onMapCreated: onMapCreated,
                    mapObjects: pointsList,
                  ),
                ),
                Positioned(
                  bottom: 4.0,
                  left: 4.0,
                  child: MapButton(
                    onTap: zoomIn,
                    icon: Icons.add,
                  ),
                ),
                Positioned(
                  bottom: 4.0,
                  right: 4.0,
                  child: MapButton(
                    onTap: zoomOut,
                    icon: Icons.remove,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onMapCreated(YandexMapController controller) {
    _controller.complete(controller);
  }

  Future<void> zoomIn() async {
    YandexMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.zoomIn(), animation: animation);
  }

  Future<void> zoomOut() async {
    YandexMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.zoomOut(), animation: animation);
  }

  List<PlacemarkMapObject> pointsList = [];

  @override
  bool get wantKeepAlive => true;
}
