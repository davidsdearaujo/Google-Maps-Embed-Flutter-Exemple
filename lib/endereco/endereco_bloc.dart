import 'package:maps_test/endereco/endereco_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:maps_test/endereco/endereco_mooc.dart';
import 'package:rxdart/rxdart.dart';


class EnderecoBloc extends BlocBase{
  var _enderecosController = BehaviorSubject<List<EnderecoModel>>();
  Stream<List<EnderecoModel>> get outEnderecos => _enderecosController.stream;
  
  var _enderecoSelecionadoController = BehaviorSubject<EnderecoModel>();
  Stream<EnderecoModel> get outEnderecoSelecionado => _enderecoSelecionadoController.stream;

  Future<void> carregarEnderecos() async {
    Future.delayed(Duration(seconds: 2));
    _enderecosController.add(EnderecoMooc.getEnderecos());
  }

  void selecionarEndereco(EnderecoModel endereco) {
    _enderecoSelecionadoController.add(endereco);
  }

  @override
  void dispose(){
    _enderecosController.close();
    _enderecoSelecionadoController.close();
  }
}