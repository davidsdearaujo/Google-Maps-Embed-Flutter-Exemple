import 'package:flutter/widgets.dart';

class EnderecoModel{
  String titulo;
  String endereco;
  double latitude;
  double longitude;
  int iconCodePoint;
  IconData get iconData => IconData(iconCodePoint ?? 0xe0c8, fontFamily: 'MaterialIcons');

  EnderecoModel({this.iconCodePoint, this.endereco, this.latitude, this.longitude, this.titulo});
}