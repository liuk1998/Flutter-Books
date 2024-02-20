import 'package:flutter/material.dart';

// ! 可滚动组件-AnimatedList: AnimatedList 和 ListView 的功能大体相似, 不同的是 AnimatedList 可以在列表中插入或删除节点时执行一个动画, 在需要添加或删除列表项的场景中会提高用户体验.
// 实现下面这样的一个列表, 点击底部 + 按钮时向列表追加一个列表项, 点击每个列表项后面的删除按钮时, 删除该列表项, 添加和删除时分别执行指定的动画.

void main() {
  runApp(const AnimatedListRoute());
}

class AnimatedListRoute extends StatefulWidget {
  const AnimatedListRoute({super.key});

  @override
  _AnimatedListRouteState createState() => _AnimatedListRouteState();
}

class _AnimatedListRouteState extends State<AnimatedListRoute> {
  var data = <String>[];
  int counter = 5;
  final key = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    // * 初始的时候有5个列表项
    for (var i = 0; i < counter; i++) {
      data.add('${i + 1}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '可滚动组件-AnimatedList',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('可滚动组件-AnimatedList'),
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        ),
        body: Stack(
          children: <Widget>[
            AnimatedList(
              key: key, // 标识符
              initialItemCount: data.length, // 列表个数
              itemBuilder: (context, index, animation) {
                // * 动画组件
                return FadeTransition(
                  opacity: animation,
                  child: buildItem(context, index),
                );
              },
            ),
            buildAddBtn(),
          ],
        ),
      ),
    );
  }

  // * 构建列表项
  Widget buildItem(context, index) {
    String char = data[index];
    return ListTile(
      key: ValueKey(char),
      title: Text(char),
      // * 右侧组件
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => onDelete(context, index),
      ),
    );
  }

  // * 创建一个 + 按钮, 点击后会向列表中插入一项
  Widget buildAddBtn() {
    return Positioned(
      bottom: 30,
      left: 150,
      right: 150,
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // 添加一个列表项
          data.add('${++counter}');
          // 告诉列表项有新添加的列表项
          key.currentState!.insertItem(data.length - 1);
          print('添加 ${counter}');
        },
      ),
    );
  }

  // * 删除方法
  void onDelete(context, index) {
    key.currentState!.removeItem(
      index,
      (context, animation) {
        // 删除过程执行的是反向动画, animation.value 会从1变为0
        var item = buildItem(context, index);
        print('删除${data[index]}');
        data.removeAt(index);
        // 删除动画是一个合成动画: 渐隐 + 收缩列表项
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            // 让透明度变化的更快一些
            curve: const Interval(0.5, 1),
          ),
          // 不断缩小列表项的高度
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: 0,
            child: item,
          ),
        );
      },
      duration: const Duration(milliseconds: 200), // 动画时间为 200 ms
    );
  }
}
