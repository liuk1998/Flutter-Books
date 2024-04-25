import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// ! 文件操作-Http请求库-dio: dio是一个强大的Dart Http请求库, 支持Restful API、FormData、拦截器、请求取消、Cookie管理、文件上传/下载、超时等.
void main() {
  runApp(const MaterialApp(
    home: FutureBuilderRoute(),
    title: 'Http请求库-dio',
  ));
}

class FutureBuilderRoute extends StatefulWidget {
  const FutureBuilderRoute({Key? key}) : super(key: key);

  @override
  FutureBuilderRouteState createState() => FutureBuilderRouteState();
}

class FutureBuilderRouteState extends State<FutureBuilderRoute> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Http请求库-dio'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: _dio.get('https://api.github.com/orgs/flutterchina/repos'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              // 发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              // 请求成功, 通过项目信息构建用于显示项目名称的ListView
              return ListView(
                children: response.data
                    .map<Widget>((e) => ListTile(title: Text(e['full_name'])))
                    .toList(),
              );
            }
            // 请求未完成时弹出 loading
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
