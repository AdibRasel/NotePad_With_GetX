import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_notepad/Controller/note_controller.dart';
import 'package:my_notepad/Models/note_model.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({super.key});

  Color brownColor = Colors.brown;

  TextEditingController titleController = TextEditingController(); // instance
  TextEditingController descriptionController = TextEditingController(); // instance
  TextEditingController depController = TextEditingController(); // instance



  
  TextEditingController titleControllerUpdate = TextEditingController(); // instance
  TextEditingController descriptionControllerUpdate = TextEditingController(); // instance
  TextEditingController depControllerUpdate = TextEditingController(); // instance


  NoteController noteController = Get.put(NoteController()); // instance


  final Box box=Hive.box("notes");


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
          return ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, box, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: box.keys.length,
                itemBuilder: (context, index){

                  NoteModel note=box.getAt(index);

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: ListTile(
                        leading: Text(
                          index.toString()
                        ),
                        title: Text(
                          note.title
                        ),
                        subtitle: Text(
                          note.description
                        ),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: (){
                                  _showUpdate(context, index, note.title, note.description);
                                },
                                child: Icon(Icons.edit),
                              ),
                              SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                  _showDelete(context, index, note.title, note.description);
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
            }
          );
        },
      ),



    );
  }


    // ============= Delete ================
  _showDelete(BuildContext context, index, title, description,){
 
    return showDialog(
      context: context,builder: (_){
        
        return Center(
          child: SingleChildScrollView(
            child: Center(
              child: AlertDialog(
                content: Column(
                  children: [
                   Text("Are you sure you want to delete the item?"),
                   SizedBox(height: 10),
                   Card(
                     child: ListTile(
                        leading: Text(
                          index.toString()
                        ),
                        title: Text(
                          title
                        ),
                        subtitle: Text(
                          description
                        ),
                      ),
                   ),

                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          }, 
                          child: Text("Cancle", style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: brownColor,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            noteController.deleteNote(index);
                            Navigator.pop(context);
                          }, 
                          child: Text("Yes", style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              
                // actions: [
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       ElevatedButton(
                //         onPressed: (){
                //           Navigator.pop(context);
                //         }, 
                //         child: Text("Cancle", style: TextStyle(color: Colors.white),),
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: brownColor,
                //         ),
                //       ),
                //       ElevatedButton(
                //         onPressed: (){
                //           noteController.deleteNote(index);
                //           Navigator.pop(context);
                //         }, 
                //         child: Text("Yes", style: TextStyle(color: Colors.white),),
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.deepOrange,
                //         ),
                //       ),
                //     ],
                //   )
                // ],
              
              ),
            ),
          ),
        );
      }
    );


  }


  // =============== Update ==================
  _showUpdate(BuildContext context, int index, String title, String description,){
    titleControllerUpdate.text = title;
    descriptionControllerUpdate.text = description;

    return showDialog(
        context: context,builder: (_){
          
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                content: Column(
                  children: [
                    TextField(
                      controller: titleControllerUpdate,
                      decoration: InputDecoration(
                        hintText: "Title",
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: descriptionControllerUpdate,
                      decoration: InputDecoration(
                        hintText: "Description",
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
                        NoteModel(titleControllerUpdate.text, descriptionControllerUpdate.text,),
                        index
                      );
                      Navigator.pop(context);


                    }, 
                    child: Text("Update", style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brownColor,
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
    titleController.text = "";
    descriptionController.text = "";

    return showDialog(
      context: context,builder: (_){
        
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              content: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: "Description",
                    ),
                  ),
                ],
              ),
            
              actions: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  child: Text("Cancel", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                ),
                ElevatedButton(
                  onPressed: (){

                    noteController.createNote(
                      NoteModel(titleController.text, descriptionController.text,)
                    );
                    Navigator.pop(context);


                  }, 
                  child: Text("Submit", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brownColor,
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