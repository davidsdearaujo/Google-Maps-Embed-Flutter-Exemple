import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_test/endereco/endereco_bloc.dart';
import 'package:maps_test/endereco/endereco_model.dart';
import 'package:maps_test/helpers/map_helper.dart';
import 'package:maps_test/home_bloc.dart';
import 'package:provider/provider.dart';

class EnderecoTile extends StatefulWidget {
  final EnderecoModel model;
  EnderecoTile(this.model);

  @override
  _EnderecoTileState createState() => _EnderecoTileState();
}

class _EnderecoTileState extends State<EnderecoTile> {
  EnderecoBloc get bloc => Provider.of<EnderecoBloc>(context);
  HomeBloc get homeBloc => Provider.of<HomeBloc>(context);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        padding: EdgeInsets.only(right: 15, bottom: 15),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Icon(
                widget.model?.iconData ?? Icons.location_on,
                size: 15,
                color: Colors.black54,
              ),
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.model.titulo,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    widget.model.endereco,
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() async {
    homeBloc.inMarkers.add([
      Marker(
        markerId: MarkerId('marker'),
        draggable: true,
        flat: false,
        position: LatLng(widget.model.latitude, widget.model.longitude),
        icon: BitmapDescriptor.defaultMarker,
        consumeTapEvents: false,
        infoWindow: InfoWindow(
          title: widget.model.titulo,
          snippet: widget.model.endereco,
        ),
      )
    ]);

    MapHelper.mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(widget.model.latitude, widget.model.longitude),
          tilt: 0.0,
          zoom: 17.0,
        ),
      ),
    );
    bloc.inEnderecoSelecionado.add(widget.model);
  }
}
