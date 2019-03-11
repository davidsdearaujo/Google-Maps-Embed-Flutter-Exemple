import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc{
  var _markersController = BehaviorSubject<List<Marker>>();
  Observable<List<Marker>> get outMarkers => _markersController.stream;
  Sink<List<Marker>> get inMarkers => _markersController.sink;


  void dispose(){
    _markersController.close();
  }
}