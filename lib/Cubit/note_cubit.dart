import 'package:bloc/bloc.dart';
import 'package:note/Hive/Hive_Helper.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  // Method to remove all notes and emit a new state
  void removeAllNotes() {
    HiveHelper.removeAll();
    emit(BodyChange()); // Emit the new state after removing all notes
  }

  void removeNotes(index) {
    HiveHelper.remove(index);
    emit(BodyChange());
  }

  void updateNotes({
    required String text,
    required int index,
  }) {
    HiveHelper.update(text: text, index: index);
    emit(BodyChange());
  }

  void addNotes(String text) {
    HiveHelper.add(text); // Add the new note
    emit(BodyChange());
  }

  void getNotes() {
    HiveHelper.get(); // Add the new note
    emit(BodyChange());
  }
}
