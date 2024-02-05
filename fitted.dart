import 'package:flutter/material.dart';

// ! 容器组件-空间适配: 子组件如何适配父组件空间? FittedBox 在布局子组件时会忽略其父组件传递的约束, 可以允许子组件无限大

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '容器组件-空间适配',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('容器组件-空间适配'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Center(
              child: Column(
                children: <Widget>[
                  // 因为父 Container 要比子 Container 小, 所以当没有指定任何适配方式时, 子组件会按照其真实大小进行绘制.
                  wContainer(BoxFit.none),
                  // * 在未指定适配方式时, 虽然 FittedBox 子组件的大小超过了 FittedBox 父 Container 的空间, 但FittedBox 自身还是要遵守其父组件传递的约束, 所以最终 FittedBox 的本身的大小是 50×50, 这也是为什么蓝色会和下面文本重叠的原因.
                  const Text('AAA'),
                  // 指定了适配方式为按照子组件的比例缩放, 尽可能多的占据父组件空间.
                  wContainer(BoxFit.contain),
                  const Text('BBB')
                ],
              ),
            )));
  }
}

Widget wContainer(BoxFit boxFit) {
  return Container(
    width: 50,
    height: 50,
    color: Colors.red,
    child: FittedBox(
      fit: boxFit,
      // 子容器超过父容器大小
      child: Container(width: 60, height: 70, color: Colors.blue),
    ),
  );
}
