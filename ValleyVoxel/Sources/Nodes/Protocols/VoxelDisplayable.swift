//
//  VoxelDisplayable.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/18.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import Foundation
import SceneKit

public protocol VoxelDisplayable: class,VoxelPaintable {
    var position: SCNVector3 { get }
}
