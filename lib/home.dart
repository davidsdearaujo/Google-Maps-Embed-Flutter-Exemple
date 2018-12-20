import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_test/endereco/endereco_widget.dart';
import 'package:maps_test/helpers/map_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController mapController;
  var workPosition = LatLng(-23.568052, -46.650649);
  var homePosition = LatLng(-23.5036509, -46.4922004);

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildMap(),
          EnderecoWidget(),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      options: GoogleMapOptions(
        myLocationEnabled: true,
        rotateGesturesEnabled: false,
        compassEnabled: true,
        cameraPosition: CameraPosition(
          bearing: 270.0,
          target: homePosition,
          tilt: 30.0,
          zoom: 17.0,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    MapHelper.mapController = controller;
  }
}
