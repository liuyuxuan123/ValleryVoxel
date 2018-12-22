//
//  VoxelTileNode.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/19.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import Foundation
import SceneKit

public class VoxelTileNode: SCNNode, VoxelSurfaceDisplayable {
    
    init(sideLength: CGFloat) {
        super.init()
        self.geometry = SCNPlane(width: sideLength, height: sideLength)
        self.setupGeometry()
    }
    
    public override convenience init() {
        self.init(color: VoxelConstants.defaultTileColor)
    }
    
    public convenience required init(color: UIColor) {
        self.init(sideLength: VoxelConstants.voxelSideLength)
        self.paint(with: color)
    }
    
    public convenience required init(image: UIImage) {
        self.init(sideLength: VoxelConstants.voxelSideLength)
        self.paint(with: image)
    }
    
    public required convenience init(colors: [UIColor], start: CGPoint, end: CGPoint) {
        self.init(sideLength: VoxelConstants.voxelSideLength)
        self.paint(with: colors, start: start, end: end)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.geometry = SCNPlane()
        self.setupGeometry()
    }
}
