import 'package:maps_test/endereco/endereco_model.dart';

class EnderecoMooc{
  static List<EnderecoModel> getEnderecos(){
    return [
      EnderecoModel(
        titulo: "Casa",
        endereco: "R. Novo Aeon, 27 - COHAB Águia de Haia, São Paulo - SP",
        iconCodePoint: 0xe88a,
        latitude: -23.5036509,
        longitude: -46.4922004,
      ),
      EnderecoModel(
        titulo: "Trabalho",
        endereco: "Alameda Santos, 705 - Jardim Paulista, São Paulo - SP",
        iconCodePoint: 0xe0af,
        latitude: -23.568052, 
        longitude: -46.650649,
      ),
    ];
  }
}