import 'package:flutter/material.dart';

// ! 容器组件-页面骨架: Scaffold 是一个路由页的骨架, 我们使用它可以很容易地拼装出一个完整的页面(导航栏、抽屉菜单、底部 Tab 导航菜单等).

void main() {
  runApp(const HomeWidget());
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int selectIndex = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '容器组件-页面骨架',
      home: Scaffold(
        // * AppBar 是一个 Material 风格的导航栏, 通过它可以设置导航栏标题、导航栏菜单、导航栏底部的Tab标题等.
        appBar: AppBar(
          title: const Text('App Name'), // 页面标题
          // 导航栏右侧菜单
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.share))
          ],
          // 导航栏背景颜色
          backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        ),
        drawer: const MyDrawer(), // * 抽屉
        // * 悬浮按钮
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
        // * 悬浮按钮的位置
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // * 底部导航
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.business), label: 'Business'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
          ],
          currentIndex: selectIndex,
          fixedColor: Colors.blue,
          onTap: onItemTapped,
        ),
        // * 底部导航(融合悬浮按钮)
        // bottomNavigationBar: BottomAppBar(
        //   color: Colors.white,
        //   shape: const CircularNotchedRectangle(),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: <Widget>[
        //       IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
        //       const SizedBox(),
        //       IconButton(onPressed: () {}, icon: const Icon(Icons.business)),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }
}

// * 抽屉组件
class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "images/head.jpg",
                        width: 80,
                      ),
                    ),
                  ),
                  const Text(
                    "LiuKe",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: const <Widget>[
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Add account'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
