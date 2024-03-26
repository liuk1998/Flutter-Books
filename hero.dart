import 'package:flutter/material.dart';

// ! 动画-Hero动画: 一个路由中显示待售商品的缩略图列表, 选择一个条目会将其跳转到一个新路由, 新路由中包含该商品的详细信息. 在 Flutter 中将图片从一个路由"飞"到另一个路由称为 hero 动画.

void main() {
  runApp(const MaterialApp(
    home: HeroAnimationRouteA(),
    title: 'Hero动画',
  ));
}

// * 假设有两个路由 A 和 B, A包含一个用户头像, 圆形, 点击后跳到 B 路由, 可以查看大图. B 显示用户头像原图, 矩形. 在 AB 两个路由之间跳转的时候, 用户头像会逐渐过渡到目标路由页的头像上.
class HeroAnimationRouteA extends StatelessWidget {
  const HeroAnimationRouteA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero动画'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            // * 水波纹组件
            InkWell(
              // * Hero 动画组件, 该组件不可以嵌套使用.
              child: Hero(
                tag: 'avatar', // * 唯一标记, 前后两个路由页 Hero 的 tag 必须相同
                child: ClipOval(
                  child: Image.asset(
                    'images/head.jpg',
                    width: 50.0,
                  ),
                ),
              ),
              // * 点击事件
              onTap: () {
                // 打开 B 路由
                // * PageRouteBuilder: 自定义路由切换动画. 可以通过 animation 参数来自定义过渡动画.
                Navigator.push(context, PageRouteBuilder(pageBuilder:
                    (BuildContext context, animation, secondaryAnimation) {
                  // * FadeTransition: 透明度动画组件.
                  return FadeTransition(
                    opacity: animation,
                    child: Scaffold(
                      appBar: AppBar(
                        title: const Text('原图'),
                      ),
                      body: const HeroAnimationRouteB(),
                    ),
                  );
                }));
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text('点击头像'),
            )
          ],
        ),
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  const HeroAnimationRouteB({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'avatar', // * 唯一标记, 前后两个路由页 Hero 的 tag 必须相同
        child: Image.asset('images/head.jpg'),
      ),
    );
  }
}
