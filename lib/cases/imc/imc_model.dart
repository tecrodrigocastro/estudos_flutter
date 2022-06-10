import 'dart:math' as math;

class ImcModel {
  double weigth;
  double heigth;

  ImcModel(this.weigth, this.heigth);

  double calculateBMI() {
    final result = weigth / math.pow(heigth, 2);
    return result;
  }
}
