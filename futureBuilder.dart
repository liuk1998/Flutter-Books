import 'package:flutter/material.dart';

// ! 功能型组件-异步UI更新(FutureBuilder、StreamBuilder): 快速实现依赖一些异步数据来动态更新UI. 比如在打开一个页面时我们需要先从互联网上获取数据, 在获取数据的过程中我们显示一个加载框, 等获取到数据时我们再渲染页面；又比如我们想展示Stream(比如文件流、互联网数据接收流)的进度.

// * 实现一个路由, 当该路由打开时我们从网上获取数据, 获取数据时弹一个加载框; 获取结束时, 如果成功则显示获取到的数据, 如果失败则显示错误.(模拟真实请求数据过程)
void main() {
  runApp(const FutureBuilderTest());
}

class FutureBuilderTest extends StatefulWidget {
  const FutureBuilderTest({super.key});

  @override
  FutureBuilderTestState createState() => FutureBuilderTestState();
}

class FutureBuilderTestState extends State<FutureBuilderTest> {
  // * 模拟请求数据过程, 隔5秒后返回一个字符串.
  Future<String> mockNetworkData() async {
    return Future.delayed(const Duration(seconds: 5), () => 'mock数据');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '异步UI更新',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('异步UI更新'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: mockNetworkData(), // * FutureBuilder依赖的 Future, 通常是一个异步耗时任务
            // * snapshot会包含当前异步任务的状态信息及结果信息. snapshot.connectionState 获取异步任务的状态信息、通过 snapshot.hasError 判断异步任务是否有错误等等.
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // 请求已结束
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // 请求失败, 显示错误
                  return Text('Error: ${snapshot.error}');
                } else {
                  // 请求成功, 显示数据
                  return Text('Contents: ${snapshot.data}');
                }
              } else {
                // 请求未结束, 显示loading
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
