import 'package:flutter/material.dart';

// ! 可滚动组件-PageView与可滚动组件子项缓存: 用于 Tab 换页效果、图片轮动以及抖音上下滑页切换视频功能等等.
// ! 可滚动组件中缓存指定子项的通用方案: 1.AutomaticKeepAlive 父组件(使用 ListView 时, 设置 addAutomaticKeepAlives 属性为 true. / 引入 AutomaticKeepAliveClientMixin 混入.). 2.使用 KeepAliveWrapper 组件: 在 AutomaticKeepAliveClientMixin 基础上封装的组件. 具体看 API 可滚动组件子项缓存.
// * AutomaticKeepAlive 的主要作用: 将列表项组件的 keepAlive 按需自动标记 为 true 或 false.
// * 当 keepAlive 标记为 false 时, 如果列表项滑出加载区域时, 列表组件将会被销毁.
// * 当 keepAlive 标记为 true 时, 当列表项滑出加载区域后, Viewport(可视区域)会将列表项组件缓存起来. 当列表项进入加载区域时, Viewport 从先从缓存中查找是否已经缓存, 如果有则直接复用, 如果没有则重新创建列表项.

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
      title: '可滚动组件-PageView与可滚动组件子项缓存',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('可滚动组件-PageView与可滚动组件子项缓存'),
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          body: PageView(
            scrollDirection: Axis.vertical, // 滑动方向为垂直方向
            // ! PageView 默认并没有缓存功能, 一旦页面滑出屏幕它就会被销毁. 对于 App 来说不友好. 比如一个新闻 App, 下面有很多频道页, 如果不支持页面缓存, 则一旦滑到新的频道旧的频道页就会销毁, 滑回去时又得重新请求数据和构建页面.
            // ! allowImplicitScrolling 为 true 时设置了预渲染区域. 前后两页. 所以需要使用可滚动组件中缓存指定子项的通用方案.
            // allowImplicitScrolling: true,
            children: children,
          )),
    );
  }
}

// * 列表项组件
class Page extends StatefulWidget {
  const Page({super.key, required this.text});

  final String text;

  @override
  _PageState createState() => _PageState();
}

// * 引入 AutomaticKeepAliveClientMixin 混入
class _PageState extends State<Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print("build ${widget.text}");
    // * 根据当前 wantKeepAlive 的值给 AutomaticKeepAlive 发送消息, AutomaticKeepAlive 收到消息后就会开始工作.
    super.build(context);

    return Center(
      child: Text(
        widget.text,
        // ignore: deprecated_member_use
        textScaleFactor: 5,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; // * 表示 AutomaticKeepAlive 是否需要缓存当前列表项.
}
