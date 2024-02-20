import 'package:flutter/material.dart';

// ! 可滚动组件-滚动监听及控制
// 创建一个 ListView, 当滚动位置发生变化时, 我们先打印出当前滚动位置, 然后判断当前位置是否超过1000像素, 如果超过则在屏幕右下角显示一个"返回顶部"的按钮, 该按钮点击后可以使ListView恢复到初始位置；如果没有超过1000像素, 则隐藏"返回顶部"按钮

void main() {
  runApp(const InfiniteListView());
}

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({super.key});

  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  ScrollController _controller = ScrollController(); // * 主要作用是控制滚动位置和监听滚动事件.
  bool showTopBtn = false; // 是否显示"返回到顶部 "按钮.

  @override
  void initState() {
    super.initState();

    // * 监听滚动事件
    _controller.addListener(() {
      // 判断当前位置是否超过1000像素, 如果超过则在屏幕右下角显示一个"返回顶部"的按钮, 否则不显示.
      if (_controller.offset < 1000 && showTopBtn) {
        setState(() {
          showTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && !showTopBtn) {
        setState(() {
          showTopBtn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '可滚动组件-滚动监听及控制',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('可滚动组件-滚动监听及控制'),
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          body: Scrollbar(
            controller: _controller,
            child: ListView.builder(
                itemCount: 100,
                // * 列表项高度固定时，显式指定高度是一个好习惯(性能消耗小)
                itemExtent: 50,
                controller: _controller,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('$index'));
                }),
          ),
          floatingActionButton: !showTopBtn
              ? null
              : FloatingActionButton(
                  child: const Icon(Icons.arrow_upward),
                  onPressed: () {
                    // * 返回到顶部时执行动画
                    _controller.animateTo(
                      .0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease, // 动画曲线
                    );
                  }),
        ));
  }

  @override
  void dispose() {
    // * 为了避免内存泄露
    _controller.dispose();
    super.dispose();
  }
}
