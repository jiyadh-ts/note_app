import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/utils/app_sessions.dart';
import 'package:note_app/utils/color_constraints.dart';
import 'package:note_app/view/Screen_one/card.dart/card.dart';
import 'package:note_app/view/dummydb.dart';

class Screenone extends StatefulWidget {
  const Screenone({super.key});

  @override
  State<Screenone> createState() => _ScreenoneState();
}

class _ScreenoneState extends State<Screenone> {
  var box=Hive.box(AppSessions.notebox);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final List notecolors = [
    ColorConstraints.lightBlue,
    ColorConstraints.lightOrange,
    ColorConstraints.lightGreen,
    ColorConstraints.lightYellow
  ];
  int selectedColorindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Note App",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: Dummydb.noteList.length,
          itemBuilder: (context, index) {
            return MyCard(
              noteList: Dummydb.noteList,
              index: index,
              onDelete: () {
                setState(() {
                  Dummydb.noteList.removeAt(index);
                });
              },
              onEdit: () {
                
                titleController.text = Dummydb.noteList[index]["Title"];
                descriptionController.text =
                    Dummydb.noteList[index]["Description"];
                dateController.text = Dummydb.noteList[index]["Date"];

                _showModalBottomSheet(context, isEdit: true, index: index);
              },
              onShare: () {},
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          descriptionController.clear();
          dateController.clear();

          _showModalBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context,
      {bool isEdit = false, int? index}) {
    showModalBottomSheet(
      backgroundColor: Colors.grey,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(8),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isEdit ? "Update Note" : "Add a Note",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: "Title",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none)),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          hintText: "Description",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none)),
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                          hintText: "Date",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.black,
                              ))),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(notecolors.length, (index) {
                          return InkWell(
                            onTap: () {
                              selectedColorindex = index;
                              setState(() {});
                            },
                            child: Container(
                              width: 80.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: notecolors[index],
                                  borderRadius: BorderRadius.circular(15),
                                  border: selectedColorindex == index
                                      ? Border.all(
                                          width: 3, color: Colors.black)
                                      : null),
                              child: Center(
                                child: selectedColorindex == index
                                    ? Icon(Icons.check)
                                    : null,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            if (isEdit && index != null) {
                              setState(() {
                                Dummydb.noteList[index] = {
                                  "Title": titleController.text,
                                  "Description": descriptionController.text,
                                  "Date": dateController.text,
                                  "colorindex": selectedColorindex,
                                };
                              });
                            } else {
                              // Add new note
                              setState(() {
                                Dummydb.noteList.add({
                                  "Title": titleController.text,
                                  "Description": descriptionController.text,
                                  "Date": dateController.text,
                                  "colorindex": selectedColorindex,
                                });
                              });
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black),
                            child: Center(
                              child: Text(
                                isEdit ? "Update" : "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
