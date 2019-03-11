import 'package:maps_test/endereco/endereco_model.dart';
import 'package:maps_test/endereco/endereco_mooc.dart';
import 'package:rxdart/rxdart.dart';


class EnderecoBloc {

  EnderecoBloc(){
    _carregarEnderecos();
  }

  var _enderecosController = BehaviorSubject<List<EnderecoModel>>();
  Observable<List<EnderecoModel>> get outEnderecos => _enderecosController.stream;
  
  var _enderecoSelecionadoController = BehaviorSubject<EnderecoModel>();
  Observable<EnderecoModel> get outEnderecoSelecionado => _enderecoSelecionadoController.stream;
  Sink<EnderecoModel> get inEnderecoSelecionado => _enderecoSelecionadoController.sink;

  Future<void> _carregarEnderecos() async {
    await Future.delayed(Duration(seconds: 2));
    _enderecosController.add(EnderecoMooc.getEnderecos());
  }

  void dispose(){
    _enderecosController.close();
    _enderecoSelecionadoController.close();
  }
}