import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// ! 可滚动组件-ListView
// todo 假设我们要从数据源异步分批拉取一些数据, 然后用ListView展示, 当我们滑动到列表末尾时, 判断是否需要再去拉取数据, 如果是, 则去拉取, 拉取过程中在表尾显示一个loading, 拉取成功后将数据插入列表, 如果不需要再去拉取, 则在表尾提示"没有更多".

void main() {
  runApp(const InfiniteListView());
}

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({super.key});

  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const loadingTag = '##loading##'; // * 表尾标记
  var wordsList = <String>[loadingTag]; // * 数据列表

  @override
  void initState() {
    super.initState();
    retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '可滚动组件-ListView 练习',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('无限加载列表'),
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          // * ListView.separated 可以在生成的列表项之间添加一个分割组件, 它比ListView.builder多了一个separatorBuilder参数, 该参数是一个分割组件生成器.
          body: Column(children: <Widget>[
            const ListTile(title: Text('单词列表')),
            // * Expanded包含的组件可以占据剩余的空间. 比如在这里的意思是数据列的高度为整列去掉 "单词列表" 导航的高度的剩余的高度.
            Expanded(
              child: ListView.separated(
                // * 列表项的数量, 如果为null, 则为无限列表.
                itemCount: wordsList.length,
                // * 列表项的构建器, 返回值为一个widget. 当列表滚动到具体的index位置时, 会调用该构建器构建列表项.
                itemBuilder: (BuildContext context, int index) {
                  // 如果到了表尾.
                  if (wordsList[index] == loadingTag) {
                    // 不足20条, 继续获取数据.
                    if (wordsList.length - 1 < 40) {
                      // 获取数据.
                      retrieveData();
                      // 加载时显示 loading.
                      return Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        // * 指定大小的盒子, SizedBox会强制设置它的子组件的宽度或者高度为指定值.
                        child: const SizedBox(
                          width: 24,
                          height: 24,
                          // * 圆形进度指示器
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    } else {
                      // 已经加载了20条数据, 不再获取数据.
                      return Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        child: const Text(
                          '没有更多了',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                  }
                  // * 显示单词列表项
                  // * ListTile 是一个固定高度的行.
                  return ListTile(
                    leading: const Icon(Icons.ac_unit), // 左侧组件
                    title: Text(wordsList[index]), // 标题
                    subtitle: const Text('by LiuKe'), // 副标题
                    trailing: const Icon(Icons.access_alarm), // 右侧组件
                  );
                },
                // * 分割器构造器
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: .0,
                ),
              ),
            )
          ])),
    );
  }

  // * 请求列表数据(模拟)
  void retrieveData() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) => {
          // * 数组方法 insertAll: 指定位置批量添加. 使用 english_words 包的 generateWordPairs() 方法每次生成 5 个单词.
          setState(() => wordsList.insertAll(wordsList.length - 1,
              generateWordPairs().take(5).map((e) => e.asPascalCase).toList()))
        });
  }
}
