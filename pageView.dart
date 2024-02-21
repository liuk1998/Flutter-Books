import 'package:flutter/material.dart';

// ! 可滚动组件-PageView: 用于 Tab 换页效果、图片轮动以及抖音上下滑页切换视频功能等等.

void main() {
  runApp(const PageViewBox());
}

class PageViewBox extends StatefulWidget {
  const PageViewBox({super.key});

  @override
  _PageViewBoxState createState() => _PageViewBoxState();
}

class _PageViewBoxState extends State<PageViewBox> {
  var children = <Widget>[];

  @override
  void initState() {
    super.initState();
    // 生成 6 个 Tab 页
    for (int i = 0; i < 6; ++i) {
      children.add(Page(text: '$i'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '可滚动组件-PageView',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('可滚动组件-PageView'),
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          body: PageView(
            scrollDirection: Axis.vertical, // 滑动方向为垂直方向
            // ! PageView 默认并没有缓存功能, 一旦页面滑出屏幕它就会被销毁. 对于 App 来说不友好. 比如一个新闻 App, 下面有很多频道页, 如果不支持页面缓存, 则一旦滑到新的频道旧的频道页就会销毁, 滑回去时又得重新请求数据和构建页面.
            // ! allowImplicitScrolling 为 true 时设置了预渲染区域. 前后两页.
            allowImplicitScrolling: true,
            children: children,
          )),
    );
  }
}

class Page extends StatefulWidget {
  const Page({super.key, required this.text});

  final String text;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        widget.text,
        // ignore: deprecated_member_use
        textScaleFactor: 5,
      ),
    );
  }
}
