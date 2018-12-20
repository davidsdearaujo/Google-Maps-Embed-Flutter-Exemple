import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper{
  static GoogleMapController _mapController;
  static GoogleMapController get mapController => _mapController;
  static set mapController(GoogleMapController controller) {
    if(_mapController == null)
      _mapController = controller;
  }
  
}