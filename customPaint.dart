import 'package:flutter/material.dart';
import 'dart:math';

// ! 自定义组件-CustomPaint 与 Canvas: 对于一些复杂或不规则的UI并且需要动态交互的场景, 我们就需要来自己绘制 UI 外观.

void main() {
  runApp(const MaterialApp(
    home: CustomPaintRoute(),
    title: 'CustomPaint 与 Canvas',
  ));
}

// * 实例: 五子棋/盘
class CustomPaintRoute extends StatelessWidget {
  const CustomPaintRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomPaint 与 Canvas'),
      ),
      body: Center(
        child: CustomPaint(
          // 当child为null时, 代表默认绘制区域大小, 如果有child则忽略此参数, 画布尺寸则为child尺寸. 如果有child但是想指定画布为特定大小, 可以使用SizeBox包裹CustomPaint实现.
          size: const Size(300, 300),
          painter: MyPainter(), // 背景画笔, 会显示在子节点后面
        ),
      ),
    );
  }
}

// * 画笔
class MyPainter extends CustomPainter {
  @override
  // Canvas: 一个画布, 包括各种绘制方法. Size: 当前绘制区域大小.
  void paint(Canvas canvas, Size size) {
    print('paint');
    var rect = Offset.zero & size;
    // 画棋盘
    drawChessboard(canvas, rect);
    // 画棋子
    drawPieces(canvas, rect);
  }

  @override
  // 判断是否需要重绘.
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// * 棋盘绘制
void drawChessboard(Canvas canvas, Rect rect) {
  // 棋盘背景
  // 创建一个画笔并配置其属性
  var paint = Paint()
    ..isAntiAlias = true // 是否抗锯齿
    ..style = PaintingStyle.fill //画笔样式: 填充
    ..color = const Color(0xFFDCC48C); // 画笔颜色
  canvas.drawRect(rect, paint); // 画矩形

  // 画棋盘网格
  paint
    ..style = PaintingStyle.stroke
    ..color = Colors.black38
    ..strokeWidth = 1.0;

  // 画横线
  for (int i = 0; i <= 15; ++i) {
    double dy = rect.top + rect.height / 15 * i;
    canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
  }

  for (int i = 0; i <= 15; ++i) {
    double dx = rect.left + rect.width / 15 * i;
    canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
  }
}

// * 棋子绘制
void drawPieces(Canvas canvas, Rect rect) {
  double eWidth = rect.width / 15;
  double eHeight = rect.height / 15;

  var paint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.black;
  // 画一个黑子
  canvas.drawCircle(
    Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
    min(eWidth / 2, eHeight / 2) - 2,
    paint,
  );
  // 画一个白子
  paint.color = Colors.white;
  canvas.drawCircle(
    Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
    min(eWidth / 2, eHeight / 2) - 2,
    paint,
  );
}
