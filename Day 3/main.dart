import 'dart:io';

List<String> list = [];
void main(List<String> args) {
  File file = File("list.txt");
  String data = file.readAsStringSync();
  list = data.split("\n");
  int rowLength = list[0].length;

  String gamma = "";
  String epsilon = "";

  for (int i = 0; i < rowLength; i++) {
    gamma += getMostOrLeastUsedBit(true, i).toString();
    epsilon += getMostOrLeastUsedBit(false, i).toString();
  }

  int gammaDec = int.parse(gamma, radix: 2);
  int epsilonDec = int.parse(epsilon, radix: 2);

  print('Gamma: BIN = $gamma, DEC = $gammaDec');
  print('Epsilon: BIN = $epsilon, DEC = $epsilonDec');
  print("Result: " + (gammaDec * epsilonDec).toString());
}

int getMostOrLeastUsedBit(bool most, int index) {
  int oneUsed = 0;
  int zeroUsed = 0;

  for (String x in list) {
    int value = int.parse(x[index]);
    oneUsed += value == 1 ? 1 : 0;
    zeroUsed += value == 0 ? 1 : 0;
  }

  if (most) {
    return zeroUsed > oneUsed ? 0 : 1;
  } else {
    return zeroUsed > oneUsed ? 1 : 0;
  }
}
