import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ! 文件操作-发起 HTTP 请求: http是Dart 官方提供的另一个网络请求类, 相比于HttpClient, 易用性提升了不少. 但是, 没有默认集成到Dart的SDK中, 所以我们需要先在pubspec中依赖它.
void main() {
  runApp(const MaterialApp(
    home: HttpTestRoute(),
    title: '发起 HTTP 请求',
  ));
}

class HttpTestRoute extends StatefulWidget {
  const HttpTestRoute({Key? key}) : super(key: key);

  @override
  HttpTestRouteState createState() => HttpTestRouteState();
}

class HttpTestRouteState extends State<HttpTestRoute> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('发起 HTTP 请求'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: httpNetwork,
              child: const Text('获取百度首页'),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50.0,
              child: Text(
                text.replaceAll(RegExp(r"\s"), ''),
              ),
            )
          ],
        ),
      ),
    );
  }

  // * 请求
  void httpNetwork() async {
    // 1.创建Client
    final client = http.Client();
    // 2.构建uri
    final url = Uri.parse("http://123.207.32.32:8000/api/v1/recommend");
    // 3.发送请求
    final response = await client.get(url);
    // 4.获取结果
    if (response.statusCode == HttpStatus.ok) {
      print(response.body);
      setState(() {
        text = response.body;
      });
    } else {
      print(response.statusCode);
    }
  }
}
