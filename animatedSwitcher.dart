import 'package:flutter/material.dart';

// ! 动画-动画切换组件(AnimatedSwitcher): 在遇到切换 UI 元素的场景, 比如Tab切换、路由切换. 为了增强用户体验, 通常在切换时都会指定一个动画, 以使切换过程显得平滑.

void main() {
  runApp(const MaterialApp(
    home: AnimatedSwitcherRoute(),
    title: '动画切换组件(AnimatedSwitcher)',
  ));
}

// * 实现一个计数器, 然后在每一次自增的过程中, 旧数字执行缩小动画隐藏, 新数字执行放大动画显示.

class AnimatedSwitcherRoute extends StatefulWidget {
  const AnimatedSwitcherRoute({super.key});

  @override
  AnimatedSwitcherRouteState createState() => AnimatedSwitcherRouteState();
}

class AnimatedSwitcherRouteState extends State<AnimatedSwitcherRoute> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画切换组件(AnimatedSwitcher)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // * AnimatedSwitcher 可以同时对其新、旧子元素添加显示(正向执行)、隐藏动画(反向执行).
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              // * 动画构建器
              transitionBuilder: (Widget child, Animation<double> animation) {
                // * 执行缩放动画
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: Text(
                '$_count',
                // * 显示指定key, 不同的key会被认为是不同的Text, 这样才能执行动画.
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _count += 1;
                });
              },
              child: const Text('+1'),
            ),
          ],
        ),
      ),
    );
  }
}
