import 'package:flutter/material.dart';
import 'dart:math' as math;

// ! 容器组件-变换

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '容器组件-变换',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('容器组件-变换'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 50, left: 20, bottom: 20),
                  color: Colors.black,
                  child: Transform(
                    alignment: Alignment.topRight, // 相对于坐标系原点的对齐方式
                    transform: Matrix4.skewY(0.8), // * 沿Y轴倾斜0.8弧度
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.orange,
                      child: const Text('倾斜'),
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.red),
                  // * 平移
                  child: Transform.translate(
                    offset: const Offset(-20, -5),
                    child: const Text('平移'),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(30),
                    color: Colors.green,
                    // * 旋转
                    child: Transform.rotate(
                      angle: math.pi / 2,
                      child: const Text('旋转'),
                    )),
                DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.lightBlue),
                  // * 缩放
                  child: Transform.scale(
                    scale: 1.5,
                    child: const Text('缩放'),
                  ),
                ),
              ],
            )));
  }
}
