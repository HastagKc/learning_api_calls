import 'package:api_learning_app/model/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  // Calling api using dio

  Future<void> getUsers() async {
    final Dio dio = Dio();

    try {
      final res = await dio.get('https://jsonplaceholder.typicode.com/users');
      final data = res.data;

      if (res.statusCode == 200) {
        List<dynamic> jsonData = data;
        for (var item in jsonData) {
          print(item);
          User user = User.fromJson(item);
          users.add(user);
        }
        setState(() {
          isLoading = false;
        });
      }
    } on DioError catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Api Calling'),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    child: Column(
                      children: [
                        Text(
                          user.id.toString(),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
