import 'package:flutter/material.dart';

// ! 基础组件-文本及样式

void main() {
  runApp(const TextWidget());
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('基础组件-文本及样式'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              const Text('显示文本'), // * Text 用于显示文本.
              Text('字符串重复六次.' * 6), // * 字符串重复六次
              const Text(
                '文本对齐',
                textAlign: TextAlign.center, // * textAlign 文本对齐
              ),
              Text(
                '文本显示的最大行数及超出隐藏.' * 10,
                maxLines: 1, // * maxLines 文本显示的最大行数
                overflow: TextOverflow.ellipsis, // * overflow 文本超出隐藏
              ),
              const Text(
                '文本缩放',
                // ignore: deprecated_member_use
                textScaleFactor: 2, // * textScaleFactor 文本缩放, 相对单位.
              ),
              Text(
                '文本样式',
                // * TextStyle 用于指定文本显示的样式如颜色、字体、粗细、背景等
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    height: 1.2, // 行高
                    fontFamily: 'Courier',
                    background: Paint()..color = Colors.orange,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dashed),
              ),
              // * TextSpan 文本片段, 对一个 Text 内容的不同部分按照不同的样式显示.
              const Text.rich(TextSpan(children: [
                TextSpan(text: '文本片段1.'),
                TextSpan(text: '文本片段2.', style: TextStyle(color: Colors.blue))
              ])),
              // * DefaultTextStyle 父级设置的默认样式, 子类文本都会默认继承使用这个样式.
              const DefaultTextStyle(
                  style: TextStyle(color: Colors.red, fontSize: 20),
                  child: Column(
                    children: <Widget>[
                      Text('子文本1'),
                      Text('子文本2'),
                      Text(
                        '子文本3',
                        style: TextStyle(
                            inherit: false, // * 不继承默认样式
                            color: Colors.grey),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
