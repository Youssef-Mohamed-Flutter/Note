import 'package:hive/hive.dart';

class HiveHelper {
  static var noteBox = "Note_Box";
  static List<String> myNotes = [];

  static void add(String text) {
    myNotes.add(text);
    Hive.box(noteBox).put(noteBox, myNotes);
  }

  static void get() {
    myNotes = Hive.box(noteBox).get(noteBox);
  }

  static void remove(int index) {
    myNotes.removeAt(index);
    Hive.box(noteBox).put(noteBox, myNotes);
  }

  static void removeAll() {
    myNotes.clear();
    Hive.box(noteBox).put(noteBox, myNotes);
  }

  static void update({
    required String text,
    required int index,
  }) {
    myNotes[index] = text;
    Hive.box(noteBox).put(noteBox, myNotes);
  }
}
