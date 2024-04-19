import 'package:flutter/material.dart';

// ! 自定义组件-组合实例 TurnBox: 实现一个TurnBox组件, 它不仅可以以任意角度来旋转其子节点, 而且可以在角度发生变化时执行一个动画以过渡到新状态, 同时, 我们可以手动指定动画速度.

void main() {
  runApp(const MaterialApp(
    home: TurnBoxRoute(),
    title: '组合实例 TurnBox',
  ));
}

// * 组合实例
class TurnBox extends StatefulWidget {
  const TurnBox({
    Key? key,
    this.turns = .0, // 旋转的圈数, 一圈为360度, 如 0.25 圈即 90 度.
    this.speed = 200, // 过渡动画执行的总时长.
    required this.child,
  }) : super(key: key);

  final double turns;
  final int speed;
  final Widget child;

  @override
  TurnBoxState createState() => TurnBoxState();
}

// 需要继承 TickerProvider, 如果有多个 AnimationController, 则应该使用 TickerProviderStateMixin。
class TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller; // 控制器

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity,
    );
    _controller.value = widget.turns;
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 旋转角度发生变化时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// * 使用示例
class TurnBoxRoute extends StatefulWidget {
  const TurnBoxRoute({Key? key}) : super(key: key);

  @override
  TurnBoxRouteState createState() => TurnBoxRouteState();
}

class TurnBoxRouteState extends State<TurnBoxRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('组合实例 TurnBox'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TurnBox(
                turns: _turns,
                speed: 500,
                child: const Icon(Icons.refresh, size: 50),
              ),
              TurnBox(
                turns: _turns,
                speed: 1000,
                child: const Icon(Icons.refresh, size: 150.0),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _turns += .2;
                  });
                },
                child: const Text('顺时针旋转1/5圈'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _turns -= .2;
                  });
                },
                child: const Text('逆时针旋转1/5圈'),
              )
            ],
          ),
        ));
  }
}
