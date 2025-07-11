import 'package:get/get.dart';
import 'package:my_notepad/Models/note_model.dart';

class NoteController extends GetxController {

  List<NoteModel> notes = [


  ];


  void createNote(NoteModel note){

    notes.add(note);
    update();

  }


  void updateNote(NoteModel note, int index){
    
    notes[index]=note; // ei index a note giye set hoye jabe
    update();

  }


  void deleteNote(int index){
    notes.removeAt(index);
    update();
  }


}