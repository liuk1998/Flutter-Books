import 'package:flutter/material.dart';

// ! 动画-动画基本结构及状态监听

void main() {
  runApp(const MaterialApp(
    home: ScaleAnimationTest(),
    title: '动画基本结构及状态监听',
  ));
}

// * 一个图片逐渐放大
class ScaleAnimationTest extends StatefulWidget {
  const ScaleAnimationTest({super.key});

  @override
  ScaleAnimationTestState createState() => ScaleAnimationTestState();
}

// * 需要继承 TickerProvider, 如果有多个 AnimationController, 则应该使用 TickerProviderStateMixin. 使用 Ticker 来驱动动画会防止屏幕外动画消耗不必要的资源.
class ScaleAnimationTestState extends State<ScaleAnimationTest>
    with SingleTickerProviderStateMixin {
  // * Animation是一个抽象类, 它本身和 UI 渲染没有任何关系, 主要的功能是保存动画的插值和状态.
  late Animation<double> animation;
  // * AnimationController用于控制动画, 它包含动画的启动 forward()、停止 stop() 、反向播放 reverse() 等方法.
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, // 主要职责是创建 Ticker.
      duration: const Duration(seconds: 3), // 表示动画执行的时长, 通过它我们可以控制动画的速度.
    );

    // * Curve 描述动画过程. 动画过程可以是匀速的、匀加速的或者先加速后减速等. 通过 CurvedAnimation 来指定动画的曲线.
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    // * Tween 可以添加映射以生成不同的范围或数据类型的值. 要使用 Tween 对象, 需要调用其 animate() 方法, 然后传入一个控制器对象, 返回的是一个 Animation.
    // 若没有指定 Curve 则为匀速, 图片宽高从 0 变到 300.
    animation = (Tween(begin: 0.0, end: 300.0).animate(controller)
      // * 用于给 Animation 添加帧监听器, 在每一帧都会被调用
      // * 调用了setState(), 所以每次动画生成一个新的数字时, 导致 build() 方法再次被调用, 改变Image的宽高, 因为它的高度和宽度现在使用的是 animation.value , 所以就会逐渐放大.
      ..addListener(() {
        setState(() => {});
      }));

    // 循环动画
    // * 通过 Animation的addStatusListener() 方法来监听动画状态的改变.
    animation.addStatusListener((status) {
      // completed: 动画在终点停止
      if (status == AnimationStatus.completed) {
        controller.reverse();
        // dismissed: 动画在起始点停止
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    // * 启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画基本结构及状态监听'),
      ),
      // 监听通知
      body: Center(
        child: Image.asset(
          'images/head.jpg',
          width: animation.value,
          height: animation.value,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
