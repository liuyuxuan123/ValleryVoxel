//
//  VoxelPlatformNode.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/19.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

open class VoxelPlatformNode: SCNNode, VoxelSurfaceDisplayable {
    
    var anchor: ARPlaneAnchor
    var voxelSideLength: CGFloat
    
    var areTilesPrepared: Bool = false
    
    init(anchor: ARPlaneAnchor, voxelSideLength: CGFloat) {
        self.anchor = anchor
        self.voxelSideLength = voxelSideLength
        
        super.init()
        self.geometry = SCNPlane(width: 0, height: 0)
        self.eulerAngles = SCNVector3(-Float.pi / 2, 0, 0)
        
        self.setupGeometry()
        self.update(anchor, animated: false)
        self.applyDefaultColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyDefaultColor() {
        self.surfaceGeometry.firstMaterial?.diffuse.contents = VoxelConstants.defaultPlatformColor
    }
    
    func update(_ anchor: ARPlaneAnchor, animated: Bool) {
        
        let extendedX = floor(CGFloat(anchor.extent.x) / voxelSideLength) * voxelSideLength
        let extendedZ = floor(CGFloat(anchor.extent.z) / voxelSideLength) * voxelSideLength
        
        let changes = {
            self.simdPosition = simd_float3(anchor.center.x, 0, anchor.center.z)
            
            if !self.areTilesPrepared {
                self.surfaceGeometry.width = min(VoxelConstants.maxSurfaceWidth, extendedX)
                self.surfaceGeometry.height = min(VoxelConstants.maxSurfaceLength, extendedZ)
            }
        }
        
        if !animated  {
            changes()
        } else {
            SCNTransaction.animate(with: 0.1, changes)
        }
    }
    
    func createTiles() {
        areTilesPrepared = true
        
        let commands: [RenderingCommand] = calculateTilesPositions().map { (position) in
            return { [weak self] in
                guard let wSelf = self else { return }
                
                let tile = VoxelTileNode()
                tile.position = position
                
                wSelf.addChildNode(tile)
            }
        }
        
        process(commands)
    }
    
    func calculateTilesPositions() -> [SCNVector3] {
        
        let nodeLength = surfaceGeometry.height
        let nodeWidth = surfaceGeometry.width
        
        let tileLength = voxelSideLength
        
        let rowCount = Int(ceil(nodeLength / tileLength))
        let columnCount = Int(ceil(nodeWidth / tileLength))
        
        let margin = tileLength / 2.0
        let z = CGFloat(margin)
        
        var result: [SCNVector3] = []
        
        (0..<rowCount).forEach { (row) in
            let y = -nodeLength / 2 + margin + CGFloat(row) * tileLength
            (0..<columnCount).forEach { (column) in
                let x = -nodeWidth / 2 + margin + CGFloat(column) * tileLength
                result.append(SCNVector3(x, y, z))
            }
        }
        
        return result
    }
}

