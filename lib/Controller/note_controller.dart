import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_notepad/Models/note_model.dart';

class NoteController extends GetxController {

  // List<NoteModel> notes = [


  // ];

  final Box box=Hive.box("notes");



  void createNote(NoteModel note){

    // notes.add(note);
    box.add(note);
    // update();

  }


  void updateNote(NoteModel note, int index){
    
    // notes[index]=note; // ei index a note giye set hoye jabe
    // update();
    box.putAt(index, note);

  }


  void deleteNote(int index){
    // notes.removeAt(index);
    // update();
    box.deleteAt(index);
  }


}