import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../session_controller/session_controller.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {


  final firestore=FirebaseFirestore.instance.collection('users');
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;

  final picker =ImagePicker();
  XFile? _image;

  Future cameraimage(BuildContext context)async{
    final imagefile= await picker.pickImage(source: ImageSource.gallery);
    if(imagefile != null){
         setState(() {
          _image = imagefile;
        });
    }
  }

  Future<String> uploadimage(BuildContext context, String formattedDate) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference = storage.ref().child('news_images/$formattedDate.jpg');

      UploadTask uploadTask = reference.putFile(File(_image!.path));

      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        final String downloadURL = await snapshot.ref.getDownloadURL();
        return downloadURL;
      } else {
        throw Exception('Image upload failed'); // Handle the error appropriately
      }
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }

  // late  String newurl ="";
  final heading =TextEditingController();
  final description =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: (){
                    cameraimage(context);
                  },
                  child: Container(
                    width: 380,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black
                      ),

                      image: _image!=null ? DecorationImage(image: FileImage(File(_image!.path)),
                          fit: BoxFit.cover):null
                    ),
                    child: _image == null
                        ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_outlined),
                        Text('Add Post'),
                      ],
                    )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: heading,
                  decoration: InputDecoration(
                    hintText: 'Add Heading',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  ),
                  maxLength: 50,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                    hintText: 'Write Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 5,
                  maxLength: 300,
                ),
                const SizedBox(
                  height: 20,
                ),

                InkWell(
                  onTap: ()async{
                    DateTime now = DateTime.now();
                    String formattedDate = "${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}";

                    uploadimage(context, formattedDate).then((newurl) {
                      FirebaseFirestore.instance.collection('news').doc(formattedDate).set({
                        'postId': formattedDate,
                        "heading": heading.text.toString(),
                        "description": description.text.toString(),
                        "image": newurl.toString(),
                        "likeCount":"0",
                        'time': FieldValue.serverTimestamp(),
                        'user id': sessionControlar().userid,
                      }).then((value) {
                        Navigator.pop(context);
                      }).catchError((error) {
                        print(error);
                      });
                    }).catchError((error) {
                      print(error);
                    });

                  },
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(child: Text('Post',style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}