import 'package:flutter/material.dart';

// ! 布局组件-层叠布局: Flutter中使用 Stack 和 Positioned 这两个组件来配合实现绝对定位. Stack允许子组件堆叠, 而 Positioned 用于根据 Stack 的四个角来确定子组件的位置.

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '布局组件-层叠布局',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('布局组件-层叠布局'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: ConstrainedBox(
              constraints: const BoxConstraints.expand(), // 随着子组件扩展.
              child: Stack(
                // 决定如何去对齐没有定位(没有使用 Positioned )或部分定位的子组件
                alignment: Alignment.center,
                // 用于确定没有定位的子组件如何去适应 Stack 的大小. StackFit.loose表示使用子组件的大小, StackFit.expand表示扩伸到 Stack 的大小.
                fit: StackFit.loose,
                children: <Widget>[
                  const Positioned(
                    left: 18,
                    child: Text('定位1'),
                  ),
                  // fit 如果为 expand 时, 子组件占满 Stack 整个空间, 因为 Stack 允许子组件堆叠, 所以会遮盖住定位1的子组件.
                  Container(
                    color: Colors.red,
                    child: const Text(
                      '我没用定位1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Positioned(
                    top: 18,
                    child: Text('定位2'),
                  ),
                ],
              ),
            )));
  }
}
