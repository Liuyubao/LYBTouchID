//
//  Tools.swift
//  FQCard
//
//  Created by 冯倩 on 2017/5/9.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

class Tools: NSObject
{
    //MARK: - 将数组转换成字符串
    public func passwordString(array: NSArray) -> String
    {
        var str = ""
        for p in array
        {
            str.append(String(describing: p))
        }
        return str
    }
    
}
