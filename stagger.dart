import 'package:flutter/material.dart';

// ! 动画-交织动画: 有候可能会需要一些复杂的动画, 这些动画可能由一个动画序列或重叠的动画组成, 要实现这种效果, 使用交织动画会非常简单.
// ! 注意: 1.要创建交织动画, 需要使用多个动画对象(Animation). 2.一个 AnimationController 控制所有的动画对象. 3.给每一个动画对象指定时间间隔.

void main() {
  runApp(const MaterialApp(
    home: StaggerRoute(),
    title: '交织动画',
  ));
}

// * 实现一个柱状图增长的动画: 1.开始时高度从0增长到300像素, 同时颜色由绿色渐变为红色, 这个过程占据整个动画时间的60%. 2.高度增长到300后, 开始沿X轴向右平移100像素, 这个过程占用整个动画时间的40%.

// * 执行动画的组件
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key? key, required this.controller}) : super(key: key) {
    height = Tween<double>(
      begin: .0,
      end: 300.0,
    ).animate(
      // * 曲线型动画(缓动动画)
      CurvedAnimation(
        // parent: 关联的 Animation<double> 对象
        parent: controller,
        // curve: 缓动类型. Interval: 时间间隔动画.
        curve: const Interval(
          0.0, // 延迟多长时间开始动画.
          0.6, // 超过多少直接就是 100% 即直接到动画终点.
          curve: Curves.ease, // 动画曲线
        ),
      ),
    );

    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.6,
          curve: Curves.ease,
        ),
      ),
    );

    padding = Tween<EdgeInsets>(
      begin: const EdgeInsets.only(left: .0),
      end: const EdgeInsets.only(left: 100.0),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.6,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );
  }

  late final Animation<double> controller;
  late final Animation<double> height;
  late final Animation<EdgeInsets> padding;
  late final Animation<Color?> color;

  Widget _buildAnimation(BuildContext context, child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}

// * 启动动画的路由
class StaggerRoute extends StatefulWidget {
  const StaggerRoute({super.key});

  @override
  StaggerRouteState createState() => StaggerRouteState();
}

class StaggerRouteState extends State<StaggerRoute>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
  }

  // 开启动画
  _playAnimation() async {
    try {
      // * 由于动画可能会意外停止(例如屏幕被退出), 因此在使用这些 API 时, 添加".orCancel"会更安全.
      // 先正向执行动画
      await _controller.forward().orCancel;
      // 再反向执行动画
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // * 捕获异常. 可能发生在组件销毁时, 计时器会被取消.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('交织动画'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _playAnimation(),
              child: const Text('开启动画'),
            ),
            Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                border: Border.all(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              // 执行动画的组件
              child: StaggerAnimation(
                controller: _controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
