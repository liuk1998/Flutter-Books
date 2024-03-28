import 'package:flutter/material.dart';

// ! 动画-动画过渡组件: 在 Widget 属性发生变化时会执行过渡动画的组件统称为"动画过渡组件".

void main() {
  runApp(const MaterialApp(
    home: AnimatedWidgetsTest(),
    title: '动画过渡组件',
  ));
}

class AnimatedWidgetsTest extends StatefulWidget {
  const AnimatedWidgetsTest({super.key});

  @override
  AnimatedWidgetsTestState createState() => AnimatedWidgetsTestState();
}

class AnimatedWidgetsTestState extends State<AnimatedWidgetsTest> {
  double _padding = 10;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = const TextStyle(color: Colors.black);
  double _opacity = 1;

  @override
  Widget build(BuildContext context) {
    var duration = const Duration(milliseconds: 400);
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画过渡组件'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _padding = 20;
                });
              },
              // * 在 padding 发生变化时会执行过渡动画到新状态.
              child: AnimatedPadding(
                duration: duration,
                padding: EdgeInsets.all(_padding),
                child: const Text("AnimatedPadding"),
              ),
            ),
            SizedBox(
              height: 50,
              child: Stack(
                children: <Widget>[
                  // * 配合 Stack 一起使用, 当定位状态发生变化时会执行过渡动画到新的状态.
                  AnimatedPositioned(
                    duration: duration,
                    left: _left,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _left = 100;
                        });
                      },
                      child: const Text("AnimatedPositioned"),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 100,
              color: Colors.grey,
              // * 当 alignment 发生变化时会执行过渡动画到新的状态.
              child: AnimatedAlign(
                duration: duration,
                alignment: _align,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _align = Alignment.center;
                    });
                  },
                  child: const Text("AnimatedAlign"),
                ),
              ),
            ),
            // * 当 Container 属性发生变化时会执行过渡动画到新的状态.
            AnimatedContainer(
              duration: duration,
              height: _height,
              color: _color,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _height = 150;
                    _color = Colors.blue;
                  });
                },
                child: const Text(
                  "AnimatedContainer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // * 当字体样式发生变化时, 子组件中继承了该样式的文本组件会动态过渡到新样式.
            AnimatedDefaultTextStyle(
              style: _style,
              duration: duration,
              child: GestureDetector(
                child: const Text("hello world"),
                onTap: () {
                  setState(() {
                    _style = const TextStyle(
                      color: Colors.blue,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Colors.blue,
                    );
                  });
                },
              ),
            ),
            // * 在透明度 opacity 发生变化时执行过渡动画到新状态.
            AnimatedOpacity(
              opacity: _opacity,
              duration: duration,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () {
                  setState(() {
                    _opacity = 0.2;
                  });
                },
                child: const Text(
                  "AnimatedOpacity",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ].map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
