import 'package:flutter/material.dart';

// ! 功能型组件-异步UI更新(FutureBuilder、StreamBuilder): 快速实现依赖一些异步数据来动态更新UI. 比如在打开一个页面时我们需要先从互联网上获取数据, 在获取数据的过程中我们显示一个加载框, 等获取到数据时我们再渲染页面；又比如我们想展示Stream(比如文件流、互联网数据接收流)的进度.

// ! 在 Dart中 Stream 也是用于接收异步事件数据, 和 Future 不同的是, 它可以接收多个异步操作的结果, 它常用于会多次读取数据的异步任务场景, 如网络内容下载、文件读写等.
// * 创建一个计时器的示例：每隔1秒, 计数加1。这里, 我们使用 Stream 来实现每隔一秒生成一个数字.
void main() {
  runApp(const StreamBuilderTest());
}

class StreamBuilderTest extends StatefulWidget {
  const StreamBuilderTest({super.key});

  @override
  StreamBuilderTestState createState() => StreamBuilderTestState();
}

class StreamBuilderTestState extends State<StreamBuilderTest> {
  // * 模拟请求数据过程, 隔5秒后返回一个字符串.
  Stream<int> counter() {
    return Stream.periodic(const Duration(seconds: 1), (i) => i);
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
          child: StreamBuilder<int>(
            stream: counter(),
            // * snapshot会包含当前异步任务的状态信息及结果信息. snapshot.connectionState 获取异步任务的状态信息、通过 snapshot.hasError 判断异步任务是否有错误等等.
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (snapshot.hasError) {
                // 请求失败, 显示错误
                return Text('Error: ${snapshot.error}');
              }
              switch (snapshot.connectionState) {
                // 当前没有异步任务.
                case ConnectionState.none:
                  return const Text('没有Stream');
                // 异步任务处于等待状态.
                case ConnectionState.waiting:
                  return const Text('等待数据...');
                // Stream处于激活状态(流上已经有数据传递了), 对于 FutureBuilder 没有该状态
                case ConnectionState.active:
                  return Text('active: ${snapshot.data}');
                // 异步任务已经终止.
                case ConnectionState.done:
                  return const Text('Stream 已关闭');
              }
            },
          ),
        ),
      ),
    );
  }
}
