import 'package:api_flutter/core/service_injector/service_injector.dart';
import 'package:api_flutter/shared/model/api_model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uri postUrl = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact App'),
      ),
      body: FutureBuilder<ApiModel>(
        future: si.apiService.getRequest(postUrl),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.error),
                SizedBox(height: 15),
                Text('There is an error!!!')
              ],
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final title = data!.body[index]['title'];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${title[0].toUpperCase()}'),
                ),
                title: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
            itemCount: snapshot.data!.body.length,
          );
        },
      ),
    );
  }
}
