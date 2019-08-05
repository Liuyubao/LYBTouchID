# LYBTouchID
本博客包含了如何实现iOS手势密码、指纹密码、faceID全步骤，包括了完整的代码。
先附上demo地址https://github.com/Liuyubao/LYBTouchID 支持swift3.0+。
1、手势密码效果：

![这里写图片描述](http://img.blog.csdn.net/20180201155512048?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
2、指纹密码效果：

![这里写图片描述](http://img.blog.csdn.net/20180201155540781?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
3、faceID效果：

![这里写图片描述](http://img.blog.csdn.net/20180201155559526?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

一、导包
------
本项目主要使用的是LocalAuthentication这个包。
![这里写图片描述](http://img.blog.csdn.net/20180201161551633?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

二、手势密码
------
在LYBMainVC中新建一个gestureView【来自冯倩】放在上方，通过手势密码之后进入主VC。

![这里写图片描述](http://img.blog.csdn.net/20180201161559537?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

三、指纹识别
------
1、 查看设备沙盒中是否有保存fingerPrint
2、如果有指纹则通过LAContext检查Touch ID是否可用
3、Touch ID可用则调用系统的指纹或者faceID验证
4、验证通过，将gestureView隐藏

![这里写图片描述](http://img.blog.csdn.net/20180201161611089?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

四、失效时间
------
4.1、系统每次进入后台，记录下来当前的时刻。

![这里写图片描述](http://img.blog.csdn.net/20180201161621033?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

4.2、系统回到前台，计算当前时间距离进入后台的时间，如果大于5s，就重新唤起gestureView。
![这里写图片描述](http://img.blog.csdn.net/20180201161630599?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvWXViYW9Mb3Vpc0xpdQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

五、github代码
----------

如果本博客对您有帮助，希望可以得到您的赞赏！
完整代码附上：https://github.com/Liuyubao/LYBTouchID




