import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:maps_test/endereco/endereco_bloc.dart';
import 'package:maps_test/endereco/endereco_model.dart';
import 'package:maps_test/endereco/endereco_tile.dart';
import 'package:maps_test/helpers/map_helper.dart';

class EnderecoWidget extends StatefulWidget {
  @override
  EnderecoWidgetState createState() {
    return new EnderecoWidgetState();
  }
}

class EnderecoWidgetState extends State<EnderecoWidget> {
  EnderecoBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = EnderecoBloc();
    bloc.carregarEnderecos();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EnderecoBloc>(
      bloc: bloc,
      child: StreamBuilder<EnderecoModel>(
        stream: bloc.outEnderecoSelecionado,
        builder: (_, enderecoSnap) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: enderecoSnap.hasData ? 20 : 130,
            ),
            child: Stack(
              children: <Widget>[
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: enderecoSnap.hasData ? 0 : 70,
                      bottom: 10,
                    ),
                    child: StreamBuilder<List<EnderecoModel>>(
                      stream: bloc.outEnderecos,
                      builder: (_, snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox(
                            height: 0,
                          );
                        } else {
                          return AnimatedContainer(
                            height: enderecoSnap.hasData ? 0 : 90,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: snapshot.data
                                    .map((model) => EnderecoTile(model))
                                    .toList(),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: enderecoSnap.hasData
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )
                        : BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                  ),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    padding: EdgeInsets.all(20),
                    child: enderecoSnap.hasData
                        ? _buildSelected(
                            enderecoSnap.data) //EnderecoTile(enderecoSnap.data)
                        : Row(
                            children: <Widget>[
                              Container(
                                width: 5,
                                height: 5,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Para onde?",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black45),
                                ),
                              )
                            ],
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelected(EnderecoModel model) {
    return InkWell(
      onTap: () {
        MapHelper.mapController.clearMarkers();
        bloc.selecionarEndereco(null);
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                model?.iconData ?? Icons.location_on,
                size: 15,
                color: Colors.black54,
              ),
            ),
            Expanded(
              child: Column(
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
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.close,
                size: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
