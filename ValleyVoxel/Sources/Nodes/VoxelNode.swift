//
//  VoxelNode.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/19.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import SceneKit
import ARKit

open class VoxelNode: SCNNode, VoxelDisplayable {
    
    public var isInstalled: Bool = true
    
    init(sideLength: CGFloat) {
        super.init()
        self.geometry = SCNBox(sideLength: sideLength)
        setupGeometry()
    }
    
    public override convenience init() {
        self.init(color: VoxelConstants.defaultFaceColor)
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
    
    public required convenience init(colors: [UIColor]) {
        self.init(sideLength: VoxelConstants.voxelSideLength)
        
        let layers = colors.map { ColoredLayer(color: $0) }
        self.updateVoxelMaterials(with: layers)
    }
    
    public required convenience init(images: [UIImage]) {
        self.init(sideLength: VoxelConstants.voxelSideLength)
        
        let layers = images.map { TexturedLayer(image: $0) }
        self.updateVoxelMaterials(with: layers)
    }
    
    public required convenience init(gradients: [([UIColor], CGPoint, CGPoint)]) {
        self.init(sideLength: VoxelConstants.voxelSideLength)
        
        let layers = gradients.map { GradientedLayer(colors: $0.0, start: $0.1, end: $0.2) }
        self.updateVoxelMaterials(with: layers)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.geometry = SCNBox()
        self.setupGeometry()
    }
}

