//
//  NumberButton.swift
//  FQCard
//
//  Created by 冯倩 on 2017/5/8.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

class NumberButton: UIButton
{

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        layer.borderColor = UIColor.hexStringToColor(hexString: ColorOfWaveBlackColor).cgColor
//        layer.borderColor = UIColor.hexStringToColor(hexString: ColorOfWaveBlueColor).cgColor
        layer.borderWidth = 5
        layer.cornerRadius = self.width * 0.5
        layer.masksToBounds = true
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
}
