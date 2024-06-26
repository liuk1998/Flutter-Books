### 1.技术特点

```
1.跨平台自绘引擎: 使用自己的高性能渲染引擎来绘制 Widget(组件), 不仅可以保证在 Android 和 iOS 上 UI 的一致性, 也可以避免对原生控件依赖而带来的限制及高昂的维护成本.
2.采用Dart语言开发.
3.高性能.
```

### 2.为什么采用 Dart 语言开发而不是 JavaScript 或者其他语言?

```
程序主要有两种运行方式：静态编译(AOT)与动态解释(JIT).
AOT 的程序在执行前程序会被提前编译为机器码. 举例: C/C++
JIT 在运行时将源码实时翻译为机器码来执行. 举例: JavaScript、python等

原因:
1.开发效率高: Flutter 在开发阶段采用 JIT 模式, 在发布时可以通过 AOT 生成高效的机器码以保证应用性能.
2.高性能.
3.快速内存分配.
4.类型安全和空安全: Dart 支持静态类型检测, 可以在编译前发现一些类型的错误. JavaScript 是一个弱类型语言.
```

### 3.框架结构

```
![](./img/img1.png)
三层：框架层、引擎层和嵌入层.

框架层: 纯 Dart实现的 SDK, 它实现了一套基础库.
1.底下两层(Foundation 和 Animation、Painting、Gestures), 底层UI库, 提供动画、手势及绘制能力.
2.Rendering 层(渲染层), 依赖于 Dart UI 层, 渲染层会构建一棵由可渲染对象组成的渲染树, 当动态更新这些对象时, 渲染树会找出变化的部分, 然后更新渲染.
3.Widgets 层(基础组件库).
4.Material 和 Cupertino 层(两种视觉风格的组件库).
```

### 4.搭建 Flutter 开发环境

```
1.搭建临时镜像(将如下环境变量添加到到用户环境变量中):
PUB_HOSTED_URL=https://pub.flutter-io.cn
FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

2.下载SDK: https://flutter.cn/docs/release/archive?tab=windows. 在磁盘中新建一个文件夹然后将安装包解压到文件夹中. 在解压后目录的flutter文件下找flutter_console.bat, 双击运行并启动flutter命令行.

3.系统全局引用flutter命令: 需要添加以下环境变量到用户PATH, flutter\bin的全路径.

4.查看是否还需要安装其他依赖: flutter doctor

5.管理flutter SDK分支: flutter channel 查看或切换分支, dev和master为开发分支.

6.升级flutter SDK: flutter upgrade
```

### 5.下载 Flutter 开发工具依赖及创建运行项目

```
VS Code的配置与使用(Ctrl+Shift+P):
1.安装flutter插件: 下载 flutter 并重启. 在配置栏中输入 doctor, 然后选择 Flutter: Run Flutter Doctor 进行验证.

2.新建 flutter 项目: 在配置栏中输入 flutter, 然后选择 Flutter: New Project, 选择模板并指定文件存储位置, 输入项目名称. 等待项目创建继续, 并显示main.dart文件.

3.运行 flutter 项目: 在项目终端中输入 flutter run -d chrome --web-port=8080 --web-hostname=127.0.0.1

4.如果有更新, 在终端中输入r, 即可刷新页面.
```

### 6.Widget 简介

```
framework.dart -> 133行

// Liuk -> 在 Flutter 中, Widget 的功能是“描述一个UI元素的配置信息”，它就是说， Widget 其实并不是表示最终绘制在设备屏幕上的显示元素，所谓的配置信息就是 Widget 接收的参数
// @immutable 代表 Widget 是不可变的, 这会限制 Widget 中定义的属性（即配置信息）必须是不可变的（final）.
// 为什么不允许 Widget 中定义的属性变化呢？因为 Flutter 中如果属性发生变化则会重新构建Widget树，即重新创建新的 Widget 实例来替换旧的 Widget 实例，所以允许 Widget 的属性变化是没有意义的，因为一旦 Widget 自己的属性变了自己就会被替换.
@immutable
abstract class Widget extends DiagnosticableTree { // DiagnosticableTree 诊断树, 作用是提供调试信息.
  const Widget({ this.key });

  final Key? key; // 作用是决定是否在下一次build时复用旧的 widget ，决定的条件在canUpdate()方法中

  @protected
  @factory
  Element createElement(); // 生成对应节点的Element对象, 在 Flutter 框架中隐式调用的, 在我们开发过程中基本不会调用到.

  @override
  String toStringShort() {
    final String type = objectRuntimeType(this, 'Widget');
    return key == null ? type : '$type-$key';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.dense;
  }

  @override
  @nonVirtual
  bool operator ==(Object other) => super == other;

  @override
  @nonVirtual
  int get hashCode => super.hashCode;

  // 作用: 是否用新的 widget 对象去更新旧 UI 树上所对应的Element对象的配置
  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }

  static int _debugConcreteSubtype(Widget widget) {
    return widget is StatefulWidget ? 1 :
           widget is StatelessWidget ? 2 :
           0;
  }
}
```

### 7.StatelessWidget 简介

```
framework.dart -> 179行

// Liuk -> 无状态的组件. 用于不需要维护状态的场景, 它通常在 build 方法中通过嵌套其他 widget 来构建UI.
abstract class StatelessWidget extends Widget {
  const StatelessWidget({ super.key });

  @override
  StatelessElement createElement() => StatelessElement(this); // 重写了createElement()方法.

  @protected
  Widget build(BuildContext context); // context参数, 表示当前 widget 在 widget 树中的上下文, 每一个 widget 都会对应一个 context 对象.
}
```

### 8.StatefulWidget 简介

```
framework.dart -> 190行

// Liuk -> 有状态的组件.
abstract class StatefulWidget extends Widget {
  const StatefulWidget({ super.key });

  @override
  StatefulElement createElement() => StatefulElement(this); // 重写了createElement()方法.

  @protected
  @factory
  State createState(); // 用于创建和 StatefulWidget 相关的状态
}
```

### 9.计数器应用示例及注释

```
main.dart
```

### 10.状态管理-Widget 管理自己的状态

```
myself.dart
```

### 11.状态管理-父Widget管理子Widget的状态

```
father.dart
```

### 12.路由管理-路由跳转及传参

```
routes.dart
```

### 13.路由管理-命名路由及传参、路由钩子

```
routesName.dart
```

### 14.包管理

```
Flutter 开发中的包管理工具, 配置文件: pubspec.yaml. (相当于Vue的package.json).

Pub仓库(Google 官方的 Dart Packages 仓库, 类似于 node 中的 npm仓库): https://pub.dev/
```

### 15.资源管理(静态数据、配置文件、图标和图片等)

```
Flutter 也使用 pubspec.yaml 文件来管理应用程序所需的资源.
例: flutter:
      assets:
        - assets/my_icon.png
        - assets/background.png

加载文本资源: 通过 rootBundle 对象(可以轻松访问主资源包)加载, 直接使用 package:flutter/services.dart 中全局静态的rootBundle对象来加载asset即可.
加载图片资源: 声明分辨率相关的图片必须根据特定的目录结构来保存asset. 否则以逻辑像素为单位. 可以通过 AssetImage 类或 Image.asset 方法(直接显示图片).
例:
…/my_icon.png
…/2.0x/my_icon.png -> 在设备像素比率为1.8的设备上将被选择.
…/3.0x/my_icon.png -> 对于2.7的设备像素比率上将被选择.

AssetImage('2.0x/my_icon.png', package: '项目名')
Image.asset('2.0x/my_icon.png', package: '项目名')
```

### 16.基础组件-文本及样式

```
text.dart
```

### 17.基础组件-按钮

```
button.dart
```

### 18.基础组件-图片及ICON

```
Material Design的字体图标库: https://material.io/tools/icons/
images.dart
```

### 19.基础组件-单选开关和复选框

```
switchAndCheckbox.dart
```

### 20.基础组件-输入框

```
textField.dart
```

### 21.基础组件-表单

```
form.dart
```

### 22.基础组件-进度指示器

```
progress.dart
```

### 23.布局组件-布局原理与约束

```
constrainedBox.dart
```

### 24.布局组件-线性布局

```
row.dart
```

### 25.布局组件-弹性布局

```
flex.dart
```

### 26.布局组件-流式布局

```
wrap.dart
```

### 27.布局组件-层叠布局

```
stack.dart
```

### 28.布局组件-对齐与相对定位

```
align.dart
```

### 29.容器组件-填充

```
padding.dart
```

### 30.容器组件-装饰容器

```
decorated.dart
```

### 31.容器组件-变换

```
transform.dart
```

### 32.容器组件-容器

```
container.dart
```

### 33.容器组件-空间适配

```
fitted.dart
```

### 34.容器组件-页面骨架

```
scaffold.dart
```

### 35.可滚动组件-Sliver布局

```
Sliver 的主要作用: 加载子组件并确定每一个子组件的布局和绘制信息, 如果 Sliver 可以包含多个子组件时, 通常会实现按需加载模型.

可滚动组件由三个角色组成: Scrollable、Viewport 和 Sliver.
Scrollable: 用于处理滑动手势, 确定滑动偏移, 滑动偏移变化时构建 Viewport.
Viewport: 显示的视窗, 即列表的可视区域.
Sliver: 视窗里显示的元素.
具体布局过程:
1.Scrollable 监听到用户滑动行为后, 根据最新的滑动偏移构建 Viewport.
2.Viewport 将当前视口信息和配置信息通过 SliverConstraints 传递给 Sliver.
3.Sliver 中对子组件(RenderBox)按需进行构建和布局, 然后确认自身的位置、绘制等信息, 保存在 geometry 中.
```

### 36.可滚动组件-ListView

```
listView1.dart
listView2.dart
```

### 37.滚动监听及控制-ScrollController

```
scrollController.dart
notification.dart
```

### 38.滚动监听及控制-AnimatedList

```
animatedList.dart
```

### 39.滚动监听及控制-网格列表

```
gridView1.dart
gridView2.dart
```

### 40.滚动监听及控制-PageView

```
pageView.dart
```

### 41.滚动监听及控制-TabBarView 与 TabBar

```
tabBarView.dart
```

### 42.滚动监听及控制-CustomScrollView 和 Slivers

```
customScrollView1.dart
```


### 43.功能型组件-数据共享

```
inheritedWidget.dart
```

### 44.功能型组件-跨组件状态共享

```
provider.dart
```

### 45.功能型组件-颜色和主题

```
colors.dart
themes.dart
```

### 46.功能型组件-按需rebuild(ValueListenableBuilder)

```
valueListenableBuilder.dart
```

### 47.功能型组件-异步UI更新(FutureBuilder、StreamBuilder)

```
futureBuilder.dart
streamBuilder.dart
```

### 48.功能型组件-对话框

```
dialog1.dart
```

### 49.事件处理与通知-触摸事件(原始指针事件处理)

```
pointer.dart
```

### 50.事件处理与通知-手势识别

```
gestureDetector1.dart
gestureDetector2.dart
```

### 51.事件处理与通知-事件总线

```
bus.dart
```

### 52.事件处理与通知-通知

```
notificationListener.dart
```

### 53.动画-动画基本结构及状态监听

```
animation.dart
```

### 54.动画-Hero动画

```
hero.dart
```

### 55.动画-交织动画

```
stagger.dart
```

### 56.动画-动画切换组件(AnimatedSwitcher)

```
animatedSwitcher.dart
```

### 57.动画-动画过渡组件

```
animatedTransition.dart
```

### 58.自定义组件-组合现有组件

```
gradientButton.dart
```

### 59.自定义组件-组合实例 TurnBox

```
turnBox.dart
```

### 60.自定义组件-CustomPaint 与 Canvas

```
customPaint.dart
```

### 61.文件操作-发起 HTTP 请求

```
http.dart
```

### 62.文件操作-Http请求库-dio

```
dio.dart
```

### 63.APP中将用到的数据生成相应的Dart Model类

```
在pubspec.yaml文件添加如下配置：
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  dio: ">=4.0.1 <5.0.0"
  freezed_annotation: "^2.0.3"
  json_annotation: "^4.4.0"
  shared_preferences: ^2.2.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  freezed: "^2.0.3"
  json_serializable: "^6.1.4"
  build_runner: any
  build_runner_core: ^7.2.9
  test: ^1.16.0
----------------------------------
将json数据拷贝到工具中进行解析：https://caijinglong.github.io/json2dart/index_ch.html
将解析后得数据粘贴到创建的dart文件中, 运行 flutter packages pub run build_runner build
生成对应的g.dart文件.
----------------------------------
shared_preferences是一个Flutter插件, 它通过Android和iOS平台提供的机制来实现数据持久化.
```

### 64.Flutter项目-lib文件下的目录
```
// ! lib文件下的目录:
// * common: 一些工具类, 如通用方法类、网络接口类、保存全局变量的静态类等
// * l10n: 国际化相关的类都在此目录下.
// * models: Json文件对应的 Dart Model 类会在此目录下.
// * states: 保存APP中需要跨组件共享的状态类.
// * routes: 存放所有路由页面类.
// * widgets: APP内封装的一些 Widget 组件都在该目录下.

// ! 项目根目录下创建的文件夹:
// * imgs: 用于保存图片.
// * fonts: 用于保存 Icon 文件.
// * jsons: 用于保存 Json 文件.
```
