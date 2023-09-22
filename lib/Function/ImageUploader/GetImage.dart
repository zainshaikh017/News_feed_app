//
//
// // ignore_for_file: use_build_context_synchronously
//
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../session_controller/session_controller.dart';
// class GetImage{
//
//   final firestore=FirebaseFirestore.instance.collection('users');
//   firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
//
//   final picker =ImagePicker();
//   XFile? _image;
//   XFile? get image=> _image;
//
//
//   Future cameraimage(BuildContext context)async{
//     final imagefile= await picker.pickImage(source: ImageSource.camera);
//     if(imagefile != null){
//
//       _image =XFile(imagefile.path);
//       uploadimage(context);
//
//     }
//   }
//
//   // final picker =ImagePicker();
//
//
//   void uploadimage(BuildContext context)async{
//
//     firebase_storage.Reference ref =firebase_storage.FirebaseStorage.instance.
//     ref('/profileimage${sessionControlar().userid}');
//
//     firebase_storage.UploadTask uploadTask=ref.putFile( File(image!.path).absolute);
//
//     await Future.value(uploadTask);
//     final newurl=await ref.getDownloadURL();
//     print('url is hereee $newurl');
//
//   }
//
//
// }