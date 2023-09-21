import 'package:flutter/material.dart';

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
        title: Text(
          'News App'
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add,size: 30,))
        ],

      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [


              Card(
                child: Container(
                  width: double.infinity,
                  // height: 300,
                  decoration: BoxDecoration(
                    color:Colors.grey.shade300
                  ),
                  child: Column(
                    children: [
                      Image.network(
                          'https://static.vecteezy.com/system/resources/thumbnails/006/299/370/original/world-breaking-news-digital-earth-hud-rotating-globe-rotating-free-video.jpg'
                      
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('manahil meshra : psot tha theaaf hestory of the indain stoeld monday loandraing ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15 ,
                              child: Image.asset('assets/logo.png',fit: BoxFit.cover,),
                            ),
                            SizedBox(width: 5,),
                            Text('Rohit meshra',style: TextStyle(
                              color: Colors.black54,
                            ),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('DEll leptop lattedute 525 mazaing letop if any one want to buy this thishydghsgdhs gdys manahil meshra : psot tha theaaf hestory of the indain stoeld monday loandraing ',
                          overflow: TextOverflow.ellipsis, // TextOverflow.ellipsis se text ko truncate karega
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black54,

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.favorite_border,
                            color: Colors.red,),
                        ),
                      )
                      
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  // height: 300,
                  decoration: BoxDecoration(
                      color:Colors.grey.shade300
                  ),
                  child: Column(
                    children: [
                      Image.network(
                          'https://static.vecteezy.com/system/resources/thumbnails/006/299/370/original/world-breaking-news-digital-earth-hud-rotating-globe-rotating-free-video.jpg'

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('manahil meshra : psot tha theaaf hestory of the indain stoeld monday loandraing ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15 ,
                              child: Image.asset('assets/logo.png',fit: BoxFit.cover,),
                            ),
                            SizedBox(width: 5,),
                            Text('Rohit meshra',style: TextStyle(
                              color: Colors.black54,
                            ),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('DEll leptop lattedute 525 mazaing letop if any one want to buy this thishydghsgdhs gdys manahil meshra : psot tha theaaf hestory of the indain stoeld monday loandraing ',
                          overflow: TextOverflow.ellipsis, // TextOverflow.ellipsis se text ko truncate karega
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black54,

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.favorite_border,
                            color: Colors.red,),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
