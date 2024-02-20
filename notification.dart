import 'package:flutter/material.dart';

// ! 可滚动组件-滚动通知: 父级组件可以通过 NotificationListener 组件来监听自己关注的通知, 这种通信方式类似于Web开发中浏览器的事件冒泡.
// * 通过 NotificationListener 监听滚动事件和通过 ScrollController 有两个主要的不同:
// * 1.NotificationListener 可以在可滚动组件到 widget 树根之间任意位置监听. 而 ScrollController 只能和具体的可滚动组件关联后才可以.
// * 2.NotificationListener 在收到滚动事件时, 通知中会携带当前滚动位置和 ViewPort 的一些信息, 而 ScrollController 只能获取当前滚动位置.
// 监听 ListView 的滚动通知, 然后显示当前滚动进度百分比.

void main() {
  runApp(const InfiniteListView());
}

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({super.key});

  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  String _progress = '0%'; // 保存进度百分比

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '可滚动组件-滚动通知',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('可滚动组件-滚动通知'),
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          body: Scrollbar(
            // 监听滚动通知
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                double progress = notification.metrics.pixels /
                    notification.metrics.maxScrollExtent;
                // 重新构建
                setState(() {
                  _progress = '${(progress * 100).toInt()}%';
                });
                return false;
                // return true; //放开此行注释后，进度条将失效
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ListView.builder(
                    itemCount: 100,
                    itemExtent: 50,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text('$index'));
                    },
                  ),
                  // 显示进度百分比
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black54,
                    child: Text(_progress),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
