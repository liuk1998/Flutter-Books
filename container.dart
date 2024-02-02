import 'package:flutter/material.dart';

// ! 容器组件-容器组件: Container是一个组合类容器, 它是 DecoratedBox、ConstrainedBox、Transform、Padding、Align等组件组合的一个多功能容器, 所以只需通过一个Container组件可以实现同时需要装饰、变换、限制的场景.

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '容器组件-容器组件',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('容器组件-容器组件'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Container(
              margin: const EdgeInsets.only(top: 50, left: 120),
              width: 200, // 卡片大小
              height: 150, // 卡片大小
              //背景装饰
              decoration: const BoxDecoration(
                  // 渐变
                  gradient: RadialGradient(
                    colors: [Colors.red, Colors.orange],
                    center: Alignment.topLeft,
                  ),
                  // 阴影
                  boxShadow: [
                    BoxShadow(color: Colors.black54, offset: Offset(2, 2))
                  ]),
              transform: Matrix4.rotationZ(.2), // 旋转
              alignment: Alignment.center, //卡片内文字居中
              child: const Text(
                '5.20',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            )));
  }
}
