import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../session_controller/session_controller.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  // XFile? _image;

  // Future<void> _pickImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     _image = image;
  //   });
  // }

  final firestore=FirebaseFirestore.instance.collection('users');
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;

  final picker =ImagePicker();
  XFile? _image;
  // XFile? get image=> _image;

  Future cameraimage(BuildContext context)async{
    final imagefile= await picker.pickImage(source: ImageSource.gallery);
    if(imagefile != null){
         setState(() {
          _image = imagefile;
        });
      // _image =XFile(imagefile.path);
      uploadimage(context);

    }
  }

  // final picker =ImagePicker();

  void uploadimage(BuildContext context)async{
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}";

    firebase_storage.Reference ref =firebase_storage.FirebaseStorage.instance.
    ref('newtemplate/$formattedDate/');

    firebase_storage.UploadTask uploadTask=ref.putFile( File(_image!.path).absolute);

    await Future.value(uploadTask);
    newurl =await ref.getDownloadURL();
    print('url is hereee $newurl');
  }
  late  String newurl ="";
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
                        : null, // Set to null when image is selected
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
                  maxLength: 30,
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
                  onTap: (){
                    FirebaseFirestore.instance.collection('news').doc().set({
                      "heading": heading.text.toString(),
                      "description" :description.text.toString(),
                      "image": newurl.toString(),
                      'time' : DateTime.timestamp(),
                      'user id': sessionControlar().userid,
                        }).then((value) {
                          Navigator.pop(context);
                    }).onError((error, stackTrace) {
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