import 'package:chopperandretrofitflutterblog/core/built_value/model/built_vehicle.dart';

class CodeRunner {
  static void runCode() {
    final car = BuiltVehicle((b) => b
      ..type = VehicleType.train //EnumClass от built_value - симуляция enum
      ..brand = "ласточка"
      ..price = 10000000
      ..passengerNames.addAll(['Пукин', 'Твоя мама', 'Еврей'])); // создание
    final copiedCar = car.rebuild((b) => b
      ..brand = 'BELAZ'
      ..type = VehicleType.car); // копирование с изменениями
    // + сравнение по занчениям переменных
    print(car);
    print("${car == copiedCar} = car is copiedCar");
    print(copiedCar);

    final carJson = car.toJson();
    print(carJson);
    print(BuiltVehicle.fromJson(carJson).rebuild((b) => b..price = 12000000));
  }
}
