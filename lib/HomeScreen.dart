

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mtf_app/addPost.dart';
import 'package:mtf_app/model_post.dart';
import 'package:mtf_app/shared_pref.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final baseUrl = "https://b517-103-17-77-3.ngrok-free.app/api";
  Future<List<Post>> getPost() async {
  Dio dio = Dio();
  Response response = await dio.get("${baseUrl}/post",
      options: Options(headers: {
        "Authorization": "Bearer ${SharedPref.pref?.get('token')}"
      },
      ));
  List<Post> listPosts =
      (response.data['data'] as List).map((e) => Post.fromJson(e)).toList();
  return listPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          "PhotoGram",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addPost(),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black87,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {});
          return getPost();
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                FutureBuilder(
                  future: getPost(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text("Ada Kesalahan");
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Card(
                              elevation: 2,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 25,
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            Text(
                                                "${snapshot.data?[index].username}"),
                                          ],
                                        ),
                                        Icon(Icons.more_horiz)
                                      ],
                                    ),
                                    Container(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 300,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${snapshot.data?[index].picture}"),
                                              fit: BoxFit.fill),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    Container(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.favorite_border),
                                        Container(
                                          width: 20,
                                        ),
                                        Icon(Icons.comment_outlined),
                                        Container(
                                          width: 20,
                                        ),
                                        Icon(Icons.send_rounded),
                                      ],
                                    ),
                                    Container(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${snapshot.data?[index].title}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Flexible(
                                            child: Text(
                                          "${snapshot.data?[index].caption}",
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    ),
                                    Container(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
