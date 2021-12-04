import 'dart:io';

List<String> list = [];
int rowLength = 12;

String gamma = "";
String epsilon = "";

void main(List<String> args) {
  File file = File("list.txt");
  String data = file.readAsStringSync();
  list = data.split("\n");
  rowLength = list[0].length;

  for (int i = 0; i < rowLength; i++) {
    gamma += getMostOrLeastUsedBit(true, i).toString();
    epsilon += getMostOrLeastUsedBit(false, i).toString();
  }

  int gammaDec = int.parse(gamma, radix: 2);
  int epsilonDec = int.parse(epsilon, radix: 2);

  print('Gamma: BIN = $gamma, DEC = $gammaDec');
  print('Epsilon: BIN = $epsilon, DEC = $epsilonDec');
  print("Result part 1: " + (gammaDec * epsilonDec).toString());

  print("");
  String oxygen = getOxygenOrCO2rating(true) ?? "";
  int oxygenDec = int.parse(oxygen, radix: 2);

  String co2 = getOxygenOrCO2rating(false) ?? "";
  int co2Dec = int.parse(co2, radix: 2);

  print('Oxygen: BIN = $oxygen, DEC = $oxygenDec');
  print('CO2: BIN = $co2, DEC = $co2Dec');
  print("Part 2 result: " + (oxygenDec * co2Dec).toString());
}

String? getOxygenOrCO2rating(bool oxygen) {
  List currentList = list.toList();
  for (int i = 0; i < rowLength && currentList.length > 1; i++) {
    int oneUsed = 0;
    int zeroUsed = 0;

    for (String x in currentList) {
      int value = int.parse(x[i]);
      oneUsed += value == 1 ? 1 : 0;
      zeroUsed += value == 0 ? 1 : 0;
    }
    if (oxygen) {
      if (zeroUsed <= oneUsed) {
        currentList.removeWhere((element) => element[i] != "0");
      } else {
        currentList.removeWhere((element) => element[i] != "1");
      }
    } else {
      if (zeroUsed > oneUsed) {
        currentList.removeWhere((element) => element[i] != "0");
      } else {
        currentList.removeWhere((element) => element[i] != "1");
      }
    }
  }
  return currentList[0];
}

int getMostOrLeastUsedBit(bool most, int index) {
  int oneUsed = 0;
  int zeroUsed = 0;

  for (String x in list) {
    int value = int.parse(x[index]);
    oneUsed += value == 1 ? 1 : 0;
    zeroUsed += value == 0 ? 1 : 0;
  }

  if (zeroUsed == oneUsed) {
    return 2;
  }
  if (most) {
    return zeroUsed > oneUsed ? 0 : 1;
  } else {
    return zeroUsed > oneUsed ? 1 : 0;
  }
}
