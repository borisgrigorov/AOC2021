import 'dart:io';

void main(List<String> args) {
  File file = File("list.txt");
  String data = file.readAsStringSync();
  List<String> list = data.split("\n");

  int increased = 0;
  int? last;

  for (int i = 0; i < list.length; i++) {
    if (i > 2) {
      int a = int.parse(list[i - 2]);
      int b = int.parse(list[i - 1]);
      int c = int.parse(list[i]);

      int sum = a + b + c;
      if (last != null) {
        if (last < sum) {
          increased += 1;
        }
      }
      last = sum;
    }
  }

  print("Result: " + increased.toString());
}
