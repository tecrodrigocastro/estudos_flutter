import 'dart:math' as math;

//regra de negocio
//atributos do que precisa
class ImcModel {
  double weigth;
  double heigth;

  ImcModel(this.weigth, this.heigth);

  double calculateBMI() {
    final result = weigth / math.pow(heigth, 2);
    return result;
  }
}
