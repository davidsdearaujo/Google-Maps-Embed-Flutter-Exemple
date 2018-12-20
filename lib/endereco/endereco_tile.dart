import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_test/endereco/endereco_bloc.dart';
import 'package:maps_test/endereco/endereco_model.dart';
import 'package:maps_test/helpers/map_helper.dart';

class EnderecoTile extends StatelessWidget {
  final EnderecoModel model;
  EnderecoTile(this.model);
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<EnderecoBloc>(context);

    return InkWell(
      onTap: () => _onTap(bloc),
      child: Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Icon(
                model?.iconData ?? Icons.location_on,
                size: 15,
                color: Colors.black54,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.titulo,
                  textAlign: TextAlign.start,
                ),
                Text(
                  model.endereco,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTap(EnderecoBloc bloc) async {
    MapHelper.mapController.clearMarkers();
    MapHelper.mapController.addMarker(
      MarkerOptions(
        draggable: true,
        position: LatLng(model.latitude, model.longitude),
        infoWindowText: InfoWindowText(model.titulo, model.endereco),
        flat: false, //Para o carro, por true
        icon: BitmapDescriptor.defaultMarker,
        consumeTapEvents: false
      ),
    );

    MapHelper.mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(model.latitude, model.longitude),
          tilt: 0.0,
          zoom: 17.0,
        ),
      ),
    );
    bloc.selecionarEndereco(model);
  }
}
