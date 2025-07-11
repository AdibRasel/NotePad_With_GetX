import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notepad/Controller/note_controller.dart';
import 'package:my_notepad/Models/note_model.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({super.key});

  Color brownColor = Colors.brown;

  TextEditingController idController = TextEditingController(); // instance
  TextEditingController nameController = TextEditingController(); // instance
  TextEditingController depController = TextEditingController(); // instance



  
  TextEditingController idControllerUpdate = TextEditingController(); // instance
  TextEditingController nameControllerUpdate = TextEditingController(); // instance
  TextEditingController depControllerUpdate = TextEditingController(); // instance


  NoteController noteController = Get.put(NoteController()); // instance


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Note", style: TextStyle(color: Colors.white),),
        backgroundColor: brownColor,
        elevation: 2,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showDialogue(context);
        },
        backgroundColor: brownColor,
        child: Icon(Icons.add, color: Colors.white,),
      ),
      body: GetBuilder<NoteController>(
        builder: (_){
          return ListView.builder(
            shrinkWrap: true,
            itemCount: noteController.notes.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: ListTile(
                    leading: Text(
                      noteController.notes[index].id
                    ),
                    title: Text(
                      noteController.notes[index].name
                    ),
                    subtitle: Text(
                      noteController.notes[index].department
                    ),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              _showUpdate(context, index, noteController.notes[index].id, noteController.notes[index].name, noteController.notes[index].department);
                            },
                            child: Icon(Icons.edit),
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            onTap: (){

                            },
                            child: Icon(Icons.delete, color: Colors.deepOrange,),
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          );
        },
      ),



    );
  }

  // =============== Update ==================

  _showUpdate(BuildContext context, int index, String id, String name, String dep){
    idControllerUpdate.text = id;
    nameControllerUpdate.text = name;
    depControllerUpdate.text = dep;

 

    return showDialog(
      context: context,builder: (_){
        
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              content: Column(
                children: [
                  TextField(
                    controller: idControllerUpdate,
                    decoration: InputDecoration(
                      hintText: "Student ID",
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: nameControllerUpdate,
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: depControllerUpdate,
                    decoration: InputDecoration(
                      hintText: "Department",
                    ),
                  ),
                ],
              ),
            
              actions: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: Text("Cancle", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                ),
                ElevatedButton(
                  onPressed: (){

                    noteController.updateNote(
                      NoteModel(idControllerUpdate.text, nameControllerUpdate.text, depControllerUpdate.text,),
                      index
                    );
                    Navigator.pop(context);


                  }, 
                  child: Text("Update", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                ),
              ],
            
            ),
          ),
        );
      }
    );


  }





  // ============= Create ================
  _showDialogue(BuildContext context){


    return showDialog(
      context: context,builder: (_){
        
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              content: Column(
                children: [
                  TextField(
                    controller: idController,
                    decoration: InputDecoration(
                      hintText: "Student ID",
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: depController,
                    decoration: InputDecoration(
                      hintText: "Department",
                    ),
                  ),
                ],
              ),
            
              actions: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: Text("Cancle", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                ),
                ElevatedButton(
                  onPressed: (){

                    noteController.createNote(
                      NoteModel(idController.text, nameController.text, depController.text)
                    );
                    Navigator.pop(context);


                  }, 
                  child: Text("Submit", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                ),
              ],
            
            ),
          ),
        );
      }
    );


  }


}