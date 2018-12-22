//
//  SCNBox+Extensions.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/19.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import ARKit
import SceneKit

extension SCNBox {
    public convenience init(sideLength: CGFloat) {
        self.init(width: sideLength,
                  height: sideLength,
                  length: sideLength,
                  chamferRadius: 0)
    }
}
