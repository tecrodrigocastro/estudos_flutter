import 'package:estudos/cases/imc/imc_model.dart';

class ImcController {
  double _weigth = 0.0;
  double _heigth = 0.0;
  String _result = '';

  String get result => _result;

  void setWeigth(String value) {
    _weigth = double.tryParse(value) ?? 0;
  }

  void setHeigth(String value) {
    _heigth = double.tryParse(value) ?? 0;
  }

  void calculateBMI() {
    final imc = ImcModel(_weigth, _heigth);
    _result = imc.calculateBMI().toStringAsFixed(2);
  }
}
