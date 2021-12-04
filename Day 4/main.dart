import 'dart:io';

List<String> list = [];
List<int> numbers = [];
List<List<List<TableCell>>> tables = [[]];
void main(List<String> args) {
  loadFile();
  list.removeAt(0);
  list.removeAt(0);
  getTables();
  play();
}

void play() {
  for (int i in numbers) {
    markNumbers(i);
    checkTables(i);
  }
}

void checkTables(int number) {
  for (List table in tables) {
    for (List row in table) {
      bool missingInRow = false;
      for (TableCell cell in row) {
        if (!cell.checked) {
          missingInRow = true;
          break;
        }
      }
      if (!missingInRow) {
        won(table, number);
        return;
      }
    }
    bool missingInColumn = false;
    for (int i = 0; i < 5; i++) {
      for (int y = 0; y < 5; y++) {
        if (!table[y][i].checked) {
          missingInColumn = true;
        }
      }
    }
    if (!missingInColumn) {
      won(table, number);
      return;
    }
  }
}

void won(List table, int currentNumber) {
  int unmarkedSum = 0;
  for (List row in table) {
    for (TableCell cell in row) {
      if (!cell.checked) {
        unmarkedSum += cell.value;
      }
    }
  }
  int score = unmarkedSum * currentNumber;
  print("Score: " + score.toString());
  exit(0);
}

void markNumbers(int number) {
  for (List table in tables) {
    for (List row in table) {
      for (TableCell cell in row) {
        if (cell.value == number) {
          cell.checked = true;
        }
      }
    }
  }
}

void getTables() {
  for (String x in list) {
    if (x.length == 0) {
      tables.add([]);
    } else {
      List<String> splittedString = x.split(" ");
      splittedString.removeWhere((element) => element.length == 0);
      tables.last.add(splittedString.map((e) {
        return TableCell(int.parse(e.trim()), false);
      }).toList());
    }
  }
}

void loadFile() {
  File file = File("day4.txt");
  String data = file.readAsStringSync();
  list = data.split("\n");
  numbers = list[0].split(",").map((e) => int.parse(e)).toList();
}

class TableCell {
  bool checked;
  int value;

  TableCell(this.value, this.checked);
}
