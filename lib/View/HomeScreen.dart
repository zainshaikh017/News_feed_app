import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_feed_app/Function/Firebase/FirebaseUtils.dart';
import 'package:news_feed_app/View/Add_Product.dart';
import 'package:news_feed_app/session_controller/session_controller.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map<String, bool> isLikedMap = {};
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
                    .collection('news').orderBy('postId',descending: true)
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
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,


                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      final postID = post['postId'];
                      final userID = sessionControlar().userid;
                      var isLiked = isLikedMap[postID] ?? false;
                      // final postRef = FirebaseFirestore.instance.collection('posts').doc('your_post_document_id');
                      // final query = postRef.collection('likes').where('likedBy', arrayContains: userID);


                      return Card(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color:Colors.grey.shade300
                          ),
                          child: Column(
                            children: [
                            SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage, // You can use a transparent placeholder or any other widget/image
                              image: snapshot.data!.docs[index]['image'],
                              fit: BoxFit.fill, // Adjust the BoxFit as needed
                              fadeInDuration: const Duration(milliseconds: 200), // Duration for the fade-in animation
                              fadeOutDuration: const Duration(milliseconds: 100), // Duration for the fade-out animation
                              imageErrorBuilder: (context, error, stackTrace) {
                                // Handle the error (e.g., show an error message or another placeholder)
                                return const Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(

                                    ),
                                  ),
                                ); // Replace with your error placeholder
                              },

                          ),
                            ),
                              const SizedBox(
                                height: 10,
                              ),
                               Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(snapshot.data!.docs[index]['heading'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                               Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(snapshot.data!.docs[index]['description'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // Check if the user has liked the post
                                          if (!isLiked) {
                                            // If the user hasn't liked the post, increment the like count
                                            FirebaseFirestore.instance
                                                .collection('news')
                                                .doc(postID)
                                                .update({
                                              'likeCount': FieldValue.arrayUnion([userID])

                                            })
                                                .then((_) {
                                              setState(() {
                                                isLikedMap[postID] = true; // Mark as liked
                                              });
                                            });
                                          } else {
                                            // If the user has liked the post, decrement the like count
                                            FirebaseFirestore.instance
                                                .collection('news')
                                                .doc(postID)
                                                .update({
                                              'likeCount': FieldValue.arrayRemove([userID])
                                               // Decrement the like count by 1
                                            })
                                                .then((_) {
                                              setState(() {
                                                isLikedMap[postID] = false; // Mark as unliked
                                              });
                                            });
                                          }
                                        },
                                        icon: Icon(
    snapshot.data!.docs[index]['likeCount'].contains(userID) ? Icons.favorite : Icons.favorite_border,
                                          color: snapshot.data!.docs[index]['likeCount'].contains(userID) ? Colors.red : Colors.grey,
                                        ),
                                      ),

                                      Text("${snapshot.data!.docs[index]['likeCount'].length} Liked"),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                "${snapshot.data!.docs[index]['likeCount'].contains(userID) ? 'Liked' : 'Not Liked'}",
                              )

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










// careers@irenictech.com

//
//
// IconButton(
// onPressed: () async {
// final postID = snapshot.data!.docs[index].id;
// final user = sessionControlar().userid;
//
// if (user == null) {
// // User not logged in, handle accordingly
// return;
// }
//
// final docRef =
// FirebaseFirestore.instance.collection('news').doc(postID);
//
// final doc = await docRef.get();
//
// if (doc.exists) {
// final isLiked = doc.get('likes').contains(user);
//
// if (!isLiked) {
// // If the user hasn't liked the post, add their UID to the 'likes' array
// await docRef.update({
// 'likes': FieldValue.arrayUnion([user]),
// });
// } else {
// // If the user has liked the post, remove their UID from the 'likes' array
// await docRef.update({
// 'likes': FieldValue.arrayRemove([user]),
// });
// }
// }
// },
// icon: StreamBuilder<DocumentSnapshot>(
// stream: FirebaseFirestore.instance
//     .collection('news')
//     .doc(snapshot.data!.docs[index].id)
//     .snapshots(),
// builder: (context, snapshot) {
// if (!snapshot.hasData) {
// return Icon(
// Icons.favorite_border,
// color: Colors.grey,
// );
// }
// final user = sessionControlar().userid;
// final isLiked = snapshot.data!.get('likes').contains(user);
//
// return Icon(
// isLiked ? Icons.favorite : Icons.favorite_border,
// color: isLiked ? Colors.red : Colors.grey,
// );
// },
// ),
// ),