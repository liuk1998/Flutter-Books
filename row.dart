import 'package:flutter/material.dart';

// ! 布局组件-线性布局: 沿水平或垂直方向排列子组件. 有主轴和纵轴之分, 布局是沿水平方向(主轴指水平方向，纵轴指垂直方向). 布局沿垂直方向(主轴指垂直方向，纵轴指水平方向).

// todo 特殊情况: 如果 Row 里面嵌套 Row, 或者 Column 里面再嵌套 Column, 那么只有最外面的 Row 或 Column 会占用尽可能大的空间, 里面 Row 或 Column 所占用的空间为实际大小.

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '布局组件-线性布局',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('布局组件-线性布局'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // * 沿水平方向排列
            Row(
              // ? 子组件在Row所占用的水平空间内对齐方式, start/center/end
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text('hello world.'), Text('I am LiuKe.')],
            ),
            Row(
              // ? Row在主轴(水平)方向占用的空间, 默认是 MainAxisSize.max(表示占用一整行的空间), MainAxisSize.min(表示占用空间为子组件的自身空间).
              mainAxisSize: MainAxisSize.min,
              // 因为占用空间为子组件自身的空间, 所以居中无效.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text('hello world.'), Text('I am LiuKe.')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // * 水平方向子组件的布局顺序(是从左往右还是从右往左).
              textDirection: TextDirection.rtl,
              children: <Widget>[Text('hello world.'), Text('I am LiuKe.')],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // * Row纵轴(垂直)的对齐方向, 默认是 VerticalDirection.down, 表示从上到下.
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Text(
                  'hello world.',
                  style: TextStyle(fontSize: 30),
                ),
                Text('I am LiuKe.')
              ],
            )
          ],
        ),
      ),
    );
  }
}
