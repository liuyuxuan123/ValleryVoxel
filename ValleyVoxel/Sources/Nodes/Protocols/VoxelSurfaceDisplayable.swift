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

public protocol VoxelSurfaceDisplayable: Displayable {
    var surfaceGeometry: SCNPlane { get }
}

extension VoxelSurfaceDisplayable where Self: SCNNode {
    public var surfaceGeometry: SCNPlane {
        guard let surfaceGeometry = geometry as? SCNPlane else {
            fatalError("Geometry must be of SCNPlane type.")
        }
        return surfaceGeometry
    }
}

extension VoxelSurfaceDisplayable {
    
    // surfaceMaterial -> return surfaceGeometry.firstMaterial
    public var surfaceMaterial: SCNMaterial {
        guard let material = surfaceGeometry.firstMaterial else {
            fatalError("Surface material is not set.")
        }
        return material
    }
    
    func setupGeometry() {
        surfaceGeometry.firstMaterial = SCNMaterial()
        // A Boolean value that determines whether SceneKit should render both front and back faces of a surface. Animatable.
        // Maybe can be used to optimize the project
        surfaceGeometry.firstMaterial?.isDoubleSided = true
    }
    
    func updateSurfaceMaterial(with contents: AnyObject) {
        // Diffuse contents can be -> CALayer
        // Can be optimized
        surfaceMaterial.diffuse.contents = contents
    }
    
    func updateSurfaceTransparency(with value: CGFloat) {
        surfaceMaterial.transparency = value
    }
}
extension VoxelSurfaceDisplayable {
    
    // Execute Command Without Animation
    public func apply(_ command: VoxelPaintCommand ) {
        apply(command, animated: false)
    }
    
    // Execute Command With a Completion
    public func apply(_ command: VoxelPaintCommand, animated: Bool, completion: (() -> Void)? = nil) {
        let changes = {
            switch command {
            case .color(let content):
                self.paint(with: content)
            case .image(let content):
                self.paint(with: content)
            case .gradient(let contents, let start, let end):
                self.paint(with: contents, start: start, end: end)
            case .transparency(let value):
                self.updateSurfaceTransparency(with: value)
            default:
                debugPrint("Command: \(command) is not supported by instance of type: \(type(of: self))")
                break
            }
        }
        
        if animated {
            SCNTransaction.animate(with: VoxelConstants.defaultAnimationDuration, changes, completion)
        } else {
            changes()
            completion?()
        }
    }
    
    public func paint(with color: UIColor) {
        let layer = ColoredLayer(color: color)
        updateSurfaceMaterial(with: layer)
    }
    
    public func paint(with image: UIImage) {
        let layer = TexturedLayer(image: image)
        updateSurfaceMaterial(with: layer)
    }
    
    public func paint(with colors: [UIColor], start: CGPoint, end: CGPoint) {
        let layer = GradientedLayer(colors: colors, start: start, end: end)
        updateSurfaceMaterial(with: layer)
    }
}
