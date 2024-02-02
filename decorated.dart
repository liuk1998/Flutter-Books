import 'package:flutter/material.dart';

// ! 容器组件-装饰容器

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '容器组件-装饰容器',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('容器组件-装饰容器'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            // * DecoratedBox 可以在其子组件绘制前(或后)绘制一些装饰.
            body: DecoratedBox(
              // decoration: 将要绘制的装饰. 通过 BoxDecoration 类可绘制的属性有 color(颜色)、image(图片)、border(边框)、borderRadius(圆角)、boxShadow(阴影)、gradient(渐变)、backgroundBlendMode(背景混合模式)、shape(形状).
              decoration: BoxDecoration(
                  // 背景渐变
                  gradient: LinearGradient(
                      colors: [Colors.red, Colors.orange.shade700]),
                  borderRadius: BorderRadius.circular(3), // 圆角
                  // 阴影
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2, 2),
                        blurRadius: 4)
                  ]),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
                child: Text(
                  '登录',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )));
  }
}
