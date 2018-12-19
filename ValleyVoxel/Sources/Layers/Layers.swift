//
//  Layers.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/18.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import Foundation
import UIKit

class BorderedLayer: CALayer{
    override var frame: CGRect{
        didSet{
            // Automatically set the border width
            borderWidth = frame.width / 20
        }
    }
    
    override init() {
        super.init()
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.borderColor = UIColor.black.cgColor
        self.shouldRasterize = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
