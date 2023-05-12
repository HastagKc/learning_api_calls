import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getApi();
  }

  // creating a Future method

  Future getApi() async {
    setState(() {
      isLoading = true;
    });

    try {
      final Dio dio = Dio();

      final res = await dio.get('https://jsonplaceholder.typicode.com/posts');

      if (res.statusCode == 200) {
        List<dynamic> jsonData = res.data;

        for (var item in jsonData) {
          Post post = Post.fromJson(item);
          //! adding item to empty list
          posts.add(post);
        }
      } else {
        print('Request failed with status code: ${res.statusCode}');
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Calling'),
      ),
      body: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(posts[index].userId.toString()),
                    SizedBox(height: 10),
                    Text(posts[index].title.toString()),
                    SizedBox(height: 20),
                    Text(posts[index].body.toString()),
                  ],
                );
              },
            ),
    );
  }
}
