

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class addPost extends StatefulWidget {
  const addPost({super.key});

  @override
  State<addPost> createState() => _addPostState();
}



class _addPostState extends State<addPost> {
   Future<void> pickImage(File SelectedImage) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    setState(() {
      SelectedImage = File("${result.files.single.path}");
    });
  } else {
    // User canceled the picker
  }
}

  @override
  Widget build(BuildContext context) {
    File Selectedimage = File("");
    return Scaffold(
      appBar: AppBar(
        title: Text("New Post"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Container(
                  height: 5,
                ),
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
                ElevatedButton(onPressed: () {
                  pickImage(Selectedimage);
                  print(Selectedimage);
                }, child: Text("Add Picture")),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Title...",
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Title...",
                    ),
                  ),
                ),
                Container(
                  height: 30,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Post"),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
