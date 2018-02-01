//
//  GestureView.swift
//  FQCard
//
//  Created by 冯倩 on 2017/5/8.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

class GestureView: UIView
{
    //路径
    var path:UIBezierPath = UIBezierPath()
    //存储已经路过的点
    var pointsArray = [CGPoint]()
    //当前手指所在点
    var fingurePoint:CGPoint!
    //密码存储
    var passwordArray = [Int]()
    //初次登陆时候的最多输入次数
    var inputCount:Int = 0
    //控制是否初次登陆
    var isFirst:Bool = true
    //控制是否修改密码
    var isChangeGestures:Bool = false
    
    
    //MARK: - Override
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        //手势密码
        gesturePasswordLayoutUI()        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect,changeGestures:Bool)
    {
        super.init(frame: frame)
        print("hahahhahahhahahaha")
        //手势密码
        isChangeGestures = changeGestures
        gesturePasswordLayoutUI()
    }
    
    
    //MARK: - 懒加载
    lazy var messagerLabel : UILabel =
    {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    //MARK: - UI
    
    func gesturePasswordLayoutUI()
    {
        self.backgroundColor = UIColor.white
        //添加提示框
        addSubview(messagerLabel)
        messagerLabel.frame = CGRect(x: 0, y: 100, width: ScreenWidth, height: 50)
        //添加手势密码
        gesturePasswordUI()
        //设置path
        path.lineWidth = 2
        
        //是否修改密码
        if isChangeGestures
        {
            print("这是修改密码界面")
//            UserDefaults.standard.removeObject(forKey: "passWord")
            UserDefaults.standard.removeObject(forKey: "newPassWord")
            messagerLabel.text = "请输入新的手势密码"
            
        }
        else
        {
            print("不是修改密码界面")
            //本地密码
            let passWord = UserDefaults.standard.value(forKey: "passWord")
            if(passWord != nil)
            {
                isFirst = false
                messagerLabel.text = "确认手势密码"
            }
            else
            {
                messagerLabel.text = "请创建手势密码"
            }
        }
        

    }
    
    func gesturePasswordUI()
    {
        self.backgroundColor = UIColor.white
        
        //画密码
        let width:CGFloat = 60.0
        let height:CGFloat = width
        var x:CGFloat = 0
        var y:CGFloat = 0
        //计算空隙
        let spaceWidth = (ScreenWidth - 3 * width) / 4
        let spaceHeight = (ScreenHeight - 3 * height) / 4
        for index in 0..<9
        {
            //计算当前所在行
            let row = index % 3
            let line = index / 3
            //计算坐标
            x = CGFloat(row) * width + CGFloat(row + 1) * spaceWidth
            y = CGFloat(100 * line) + spaceHeight * 2
            let button = NumberButton(frame: CGRect(x: x, y: y, width: width, height: height))
            button.tag = index
            addSubview(button)
        }
    }

    //MARK: 绘制
    override func draw(_ rect: CGRect)
    {
        self.path.removeAllPoints()
        for (index,point) in pointsArray.enumerated()
        {
            
            if index == 0
            {
                path.move(to: point)
            }
            else
            {
                path.addLine(to: point)
            }
            
        }
        //让画线跟随手指
        if self.fingurePoint != CGPoint.zero && self.pointsArray.count > 0
        {
            path.addLine(to: self.fingurePoint)
        }
        
        //设置线的颜色
        let color = UIColor.hexStringToColor(hexString: ColorOfWaveBlackColor)
        color.set()
        path.stroke()
        
    }
    
    
    
    //MARK: - Other Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //每次点击移除所有存储过的点，重新统计
        pointsArray.removeAll()
        touchChanged(touch: touches.first!)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        touchChanged(touch: touches.first!)
    }
    
    func touchChanged(touch:UITouch)
    {
        let point = touch.location(in: self)
        fingurePoint = point
        for button in subviews
        {
            if button.isKind(of: NumberButton.self) && !pointsArray.contains(button.center) && button.frame.contains(point)
            {
                //记录已经走过的点
                passwordArray.append(button.tag)
                //记录密码
                pointsArray.append(button.center)
                //设置按钮的背景色
                button.backgroundColor = UIColor.hexStringToColor(hexString: ColorOfBlackColor)
            }
            
        }
        //会调用draw 方法
        setNeedsDisplay()
    }
    
    
    //松手的时候调用
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if(passwordArray as NSArray).count == 0
        {
            return
        }
        inputCount += 1
        
        //本地存储
        let passWord = UserDefaults.standard.value(forKey: "passWord")
        let newPassWord = UserDefaults.standard.value(forKey: "newPassWord")
        //修改密码界面
        if isChangeGestures
        {
            if(newPassWord != nil )
            {
 
                print("输入的是什么\(passwordArray),保存的是什么\(String(describing: newPassWord))")
                if Tools().passwordString(array: passwordArray as NSArray) == Tools().passwordString(array: newPassWord as! NSArray)
                {
                    messagerLabel.text = "设置成功"
                    isHidden = true
                    UserDefaults.standard.set(passwordArray, forKey: "passWord")
                    
                }
                else
                {
                    if inputCount < 5
                    {
                        messagerLabel.text = "输入错误,还可以输入\(5 - inputCount)次"
                    }
                    else
                    {
                        messagerLabel.text = "请重置手势密码"
                        inputCount = 0
                        UserDefaults.standard.removeObject(forKey: "newPassWord")
                    }
                    
                }

            }
            else//初次储存新密码
            {
                print("此时你初次存储密码,密码是\(passwordArray),长度是\((passwordArray as NSArray).count)")
                UserDefaults.standard.set(passwordArray, forKey: "newPassWord")
            }
            
            
            
        }
        //非修改密码界面
        else
        {
            //初次登陆,五次设置密码的机会
            if isFirst
            {
                if(passWord != nil && (passWord as! NSArray).count > 0)
                {
                    print("输入的是什么\(passwordArray),保存的是什么\(String(describing: newPassWord))")
                    if Tools().passwordString(array: passwordArray as NSArray) == Tools().passwordString(array: passWord as! NSArray)
                    {
                        messagerLabel.text = "设置成功"
                        isHidden = true
                        
                        //询问是否加入指纹验证
                        let alertController = UIAlertController(title: "通知", message: "是否使用指纹解锁", preferredStyle: .alert)
                        
                        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler:
                        {
                            (UIAlertAction) -> Void in
                            print("不加入指纹解锁")
                            UserDefaults.standard.set(false, forKey: "fingerPrint")
                        })
                        let okAction = UIAlertAction(title: "确定", style: .default, handler:
                        {
                            (UIAlertAction) -> Void in
                            print("使用指纹解锁")
                            UserDefaults.standard.set(true, forKey: "fingerPrint")
                            
                        })
                        alertController.addAction(cancelAction)
                        alertController.addAction(okAction)
                        self.viewControler().present(alertController, animated: true, completion: nil)
                        print("获取当前视图的控制器\(self.viewControler())")

                    }
                    else
                    {
                        if inputCount < 5
                        {
                            messagerLabel.text = "输入错误,还可以输入\(5 - inputCount)次"
                        }
                        else
                        {
                            messagerLabel.text = "请重置手势密码"
                            inputCount = 0
                            UserDefaults.standard.removeObject(forKey: "passWord")
                        }
                        
                    }
                }
                else//初次存储
                {
                     print("此时你初次存储密码,密码是\(passwordArray),长度是\((passwordArray as NSArray).count)")
                    messagerLabel.text = "确认手势密码"
                    UserDefaults.standard.set(passwordArray, forKey: "passWord")
                }
                
            }
            else//非初次登陆,不可重置密码,只能一直输入
            {
                if Tools().passwordString(array: passwordArray as NSArray) == Tools().passwordString(array: passWord as! NSArray)
                {
                    isHidden = true
                }
                else
                {
                    messagerLabel.text = "输入错误"
                    
                }
                
            }

            
        }
        
        //----------------------------
        //移除所有的记录
        pointsArray.removeAll()
        passwordArray.removeAll()
        path.removeAllPoints()
        setNeedsDisplay()
        fingurePoint = CGPoint.zero
        
        //清除所有按钮的选中状态
        for button in subviews
        {
            if button.isKind(of: NumberButton.self)
            {
                button.backgroundColor  =  UIColor.clear
            }
        }
        
    }
    
    
    
    
    func viewControler() -> UIViewController
    {
        // 1.获取当前视图的下一响应者
        var responder = self.next;
        let b = true
        // 2.判断当前对象是否是视图控制器
        while (b)
        {
            if (responder?.isKind(of: UIViewController.self))!
            {
                return responder as! UIViewController
            }
            else
            {
                responder = responder?.next;
            }
        }
    }
    
    //提供给其他类获取密码字符串
//    var passwordString:String
//    {
//        get
//        {
//            var str = ""
//            for p in passwordArray
//            {
//                str.append(String(p))
//            }
//            return str
//        }
//    }
      
}
