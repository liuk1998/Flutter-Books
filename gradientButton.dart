import 'package:flutter/material.dart';

// ! 自定义组件-组合现有组件

void main() {
  runApp(const MaterialApp(
    home: GradientButtonRoute(),
    title: '组合现有组件',
  ));
}

// * 实例: 自定义渐变按钮: 1.背景支持渐变色. 2.手指按下时有涟漪效果. 3.可以支持圆角
class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    this.colors,
    this.width,
    this.height,
    this.onPressed,
    this.borderRadius,
    required this.child,
  }) : super(key: key);

  // 渐变色数组
  final List<Color>? colors;
  // 按钮宽高
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  // 点击回调
  final GestureTapCallback? onPressed;
  // 子组件
  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // * 确保 colors 数组不空
    List<Color> _colors =
        colors ?? [theme.primaryColor, theme.primaryColorDark];

    // * DecoratedBox 可以支持背景色渐变和圆角.
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: _colors),
        borderRadius: borderRadius,
      ),
      child: Material(
        // 屏幕灰色透明, 相当于覆盖一个灰色透明的 div.
        type: MaterialType.transparency,
        // * InkWell 在手指按下有涟漪效果.
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// * 使用 GradientButton
class GradientButtonRoute extends StatefulWidget {
  const GradientButtonRoute({super.key});

  @override
  GradientButtonRouteState createState() => GradientButtonRouteState();
}

class GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('组合现有组件'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GradientButton(
            colors: const [Colors.orange, Colors.red],
            height: 50.0,
            onPressed: onTap,
            child: const Text('Submit'),
          ),
          GradientButton(
            colors: [Colors.lightGreen, Colors.green.shade700],
            height: 50.0,
            onPressed: onTap,
            child: const Text('Submit'),
          ),
          GradientButton(
            colors: [Colors.lightBlue.shade300, Colors.blueAccent],
            height: 50.0,
            onPressed: onTap,
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }

  onTap() {
    print('button click');
  }
}
