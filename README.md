#<center>README#
---
##娱乐

>瀑布流展示图片

图片来源接口自摩拜面试题

瀑布流实现是继承`UICollectionViewLayout`自定义一个`BQWaterLayout`

点击任意cell进入视频播放页面，这是练习`AVPlayer`的使用，功能只有播放暂停。

###关于[`BQWaterLayout`](https://github.com/PurpleSweetPotatoes/CollcetionViewLayout_demo)
是之前学习瀑布流时找到的demo，在此基础上改写了布局算法。然而这个布局算法并不完善。

##碰撞

>碰撞+重力动画

看到比较好玩的动画就尝试实现下，先想到的就是用碰撞行为和重力行为来实现。在网上找些资料参考具体细节。主要用到`CMMotionManager`、 `UIGravityBehavior`、 `UICollisionBehavior`、 `UIFieldBehavior`(扭曲力场这个比较有趣是iOS9之后新出的)。

中间也遇到一个坑：`UIDynamicAnimator`不可设置为局部变量，否则各种行为将不起作用。

`CMMotionManager`是用来管理设备行为，要实现重力方向随设备旋转而变动就需要用到它。
>A CMMotionManager object is the gateway to the motion services provided by iOS. These services provide an app with accelerometer data, rotation-rate data, magnetometer data, and other device-motion data such as attitude. These types of data originate with a device’s accelerometers and (on some models) its magnetometer and gyroscope

##折线

>画折线

使用贝塞尔曲线画线，再用`CABasicAnimation`实现动画。每个点上设置了一个button，button出现也稍微做了动画，可从上、左、下出现。

##我

>吸附动画
