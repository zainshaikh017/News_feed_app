import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_feed_app/Function/Firebase/FirebaseUtils.dart';
import 'package:news_feed_app/View/Add_Product.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'News App'
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const AddProduct();
            },));
          },
              icon: const Icon(Icons.add,size: 30,)),
          IconButton(onPressed: (){
            FirebaseUtils().signout(context);
          },
              icon: const Icon(Icons.logout,size: 30,))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('news')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No News found.'));
                  }
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,

                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          width: double.infinity,
                          // height: 300,
                          decoration: BoxDecoration(
                              color:Colors.grey.shade300
                          ),
                          child: Column(
                            children: [
                                FadeInImage.memoryNetwork(
                                  placeholder:kTransparentImage, // You can use a transparent placeholder or any other widget/image
                                  image: snapshot.data!.docs[index]['image'],
                                  fit: BoxFit.cover, // Adjust the BoxFit as needed
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                               Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(snapshot.data!.docs[index]['heading'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Row(
                              //     children: [
                              //       CircleAvatar(
                              //         radius: 15 ,
                              //         child: Image.asset('assets/logo.png',fit: BoxFit.cover,),
                              //       ),
                              //       const SizedBox(width: 5,),
                              //       const Text('Ronit mesh ra',style: TextStyle(
                              //         color: Colors.black54,
                              //       ),)
                              //     ],
                              //   ),
                              // ),
                               Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(snapshot.data!.docs[index]['description'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.favorite_border,
                                    color: Colors.red,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                    },
                  );
                },
              )




            ],

          ),
        ),
      ),
    );
  }
}
