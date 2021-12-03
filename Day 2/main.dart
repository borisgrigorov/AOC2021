import 'dart:io';

void main(List<String> args) {
  File file = File("list.txt");
  String data = file.readAsStringSync();
  List<String> list = data.split("\n");

  int depth = 0;
  int horizontalPos = 0;
  int aim = 0;

  for (final String x in list) {
    String command = x.split(" ")[0];
    int value = int.parse(x.split(" ")[1]);
    switch (command) {
      case "forward":
        horizontalPos += value;
        depth += aim * value;
        break;
      case "up":
        aim -= value;
        break;
      case "down":
        aim += value;
        break;
    }
  }

  print("Horizontal position: " + horizontalPos.toString());
  print("Depth: " + depth.toString());
  print("Result: " + (depth * horizontalPos).toString());
}
