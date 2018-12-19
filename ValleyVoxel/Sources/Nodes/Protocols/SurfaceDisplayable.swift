//
//  SurfaceDisplayable.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/18.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//


import Foundation
import ARKit
import SceneKit

public protocol SurfaceDisplayable: VoxelPaintable {
    var surfaceGeometry: SCNPlane { get }
}

extension SurfaceDisplayable where Self: SCNNode {
    public var surfaceGeometry: SCNPlane {
        guard let surfaceGeometry = geometry as? SCNPlane else {
            fatalError("Geometry must be of SCNPlane type.")
        }
        
        return surfaceGeometry
    }
}

extension SurfaceDisplayable {
    
    public var surfaceMaterial: SCNMaterial {
        guard let material = surfaceGeometry.firstMaterial else {
            fatalError("Surface material is not set.")
        }
        
        return material
    }
    
    func setupGeometry() {
        surfaceGeometry.firstMaterial = SCNMaterial()
        surfaceGeometry.firstMaterial?.isDoubleSided = true
    }
    
    func updateSurfaceMaterial(with contents: AnyObject) {
        surfaceMaterial.diffuse.contents = contents
    }
    
    func updateSurfaceTransparency(with value: CGFloat) {
        surfaceMaterial.transparency = value
    }
}
