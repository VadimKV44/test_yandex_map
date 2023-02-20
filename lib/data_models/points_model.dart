class PointsModel {
  PointsModel({
    required this.list,
  });

  List<Coordinates> list;
}

class Coordinates {
  Coordinates({
    required this.name,
    required this.lat,
    required this.lng,
  });

  String name;
  double lat;
  double lng;
}

PointsModel data = PointsModel(
  list: [
    Coordinates(name: 'Магазин', lat: 44.2, lng: 42.0),
    Coordinates(name: 'Спортзал', lat: 38.0, lng: 45.0),
    Coordinates(name: 'Магаз', lat: 39.0, lng: 40.5),
    Coordinates(name: 'Зоопарк', lat: 50.1, lng: 42.3),
    Coordinates(name: 'Клуб', lat: 36.9, lng: 41.5),
  ],
);
