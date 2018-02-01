//
//  UIView+Category.swift
//  FQCard
//
//  Created by 冯倩 on 2017/5/8.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

extension UIView
{
    
    var size:CGSize
    {
        get
        {
            return self.frame.size
        }
        set
        {
            self.frame.size = newValue
        }
    }
    
    var origin: CGPoint
    {
        get
        {
            return self.frame.origin
        }
        set
        {
            self.frame.origin = newValue
        }
    }
    
    
    var width:CGFloat
    {
        get
        {
            return self.size.width
        }
        set
        {
            self.size.width = newValue
        }
    }
    
    var height:CGFloat
    {
        get
        {
            return self.size.height
        }
        set
        {
            self.size.height = newValue
        }
    }
    
    var x:CGFloat
    {
        get
        {
            return self.origin.x
        }
        set
        {
            self.origin.x = newValue
        }
    }
    
    var y:CGFloat
    {
        get
        {
            return self.origin.y
        }
        set
        {
            self.origin.y = newValue
        }
    }
}
