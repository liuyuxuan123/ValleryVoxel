//
//  VoxelDisplayable.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/18.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import Foundation
import SceneKit

public protocol Displayable: class,VoxelPaintable {
    var position: SCNVector3 { get }
}

public protocol VoxelDisplayable: Displayable {
    var voxelGeometry: SCNBox { get }
}

extension VoxelDisplayable where Self: VoxelNode {
    public var voxelGeometry: SCNBox {
        guard let voxelGeometry = geometry as? SCNBox else {
            fatalError("Geometry must be of SCNBox type.")
        }
        
        return voxelGeometry
    }
}

extension VoxelDisplayable {
    
    func setupGeometry() {
        // Initialize with 6 material
        voxelGeometry.materials = createVoxelMaterials()
    }
    // Every Node has 6 faces -> 6 material
    func createVoxelMaterials() -> [SCNMaterial] {
        return [SCNMaterial(),
                SCNMaterial(),
                SCNMaterial(),
                SCNMaterial(),
                SCNMaterial(),
                SCNMaterial()]
    }
    
    public func voxelMaterial(for face: VoxelFace) -> SCNMaterial {
        return voxelGeometry.materials[face.rawValue]
    }
    
    func updateVoxelMaterials(with contents: AnyObject) {
        VoxelFace.all.forEach {
            updateVoxelMaterial(for: $0, newContents: contents)
        }
    }
    
    func updateVoxelMaterials(with contents: [AnyObject]) {
        // Input Content Count must be 6
        assert(contents.count == 6, "Wrong contents count: \(contents.count)")
        zip(voxelGeometry.materials, contents).forEach { (material, content) in
            material.diffuse.contents = content
        }
    }
    
    func updateVoxelMaterial(for face: VoxelFace, newContents contents: AnyObject) {
        voxelMaterial(for: face).diffuse.contents = contents
    }
    
    func updateVoxelTransparency(with value: CGFloat) {
        VoxelFace.all.forEach {
            updateVoxelTransparency(for: $0, newValue: value)
        }
    }
    
    func updateVoxelTransparency(for face: VoxelFace, newValue value: CGFloat) {
        voxelMaterial(for: face).transparency = value
    }
}


extension VoxelDisplayable {
    
    public func apply(_ command: VoxelPaintCommand) {
        apply(command, animated: false)
    }
    
    public func apply(_ commands: [VoxelPaintCommand]) {
        apply(commands, animated: false)
    }
    
    public func apply(_ command: VoxelPaintCommand, animated: Bool, completion: (() -> Void)? = nil) {
        let changes = {
            switch command {
            case .color(let content):
                self.paint(with: content)
            case .faceColor(let content, let face):
                self.paint(face: face, with: content)
            case .colors(let contents):
                zip(VoxelFace.all, contents).forEach { self.paint(face: $0.0, with: $0.1) }
                
            case .image(let content):
                self.paint(with: content)
            case .faceImage(let content, let face):
                self.paint(face: face, with: content)
            case .images(let contents):
                zip(VoxelFace.all, contents).forEach { self.paint(face: $0.0, with: $0.1) }
                
            case .gradient(let contents, let start, let end):
                self.paint(with: contents, start: start, end: end)
            case .faceGradient(let contents, let start, let end, let face):
                self.paint(face: face, with: contents, start: start, end: end)
                
            case .transparency(let value):
                self.updateVoxelTransparency(with: value)
            case .faceTransparency(let value, let face):
                self.updateVoxelTransparency(for: face, newValue: value)
            }
        }
        
        if animated {
            SCNTransaction.animate(with: VoxelConstants.defaultAnimationDuration, changes, completion)
        } else {
            changes()
            completion?()
        }
    }
    
    public func apply(_ commands: [VoxelPaintCommand], animated: Bool, completion: (() -> Void)? = nil) {
        let changes = { commands.forEach { self.apply($0, animated: false) } }
        
        if animated {
            SCNTransaction.animate(with: VoxelConstants.defaultAnimationDuration, changes, completion)
        } else {
            changes()
            completion?()
        }
    }
    
    public func paint(with color: UIColor) {
        let layer = ColoredLayer(color: color)
        updateVoxelMaterials(with: layer)
    }
    
    public func paint(with image: UIImage) {
        let layer = TexturedLayer(image: image)
        updateVoxelMaterials(with: layer)
    }
    
    public func paint(with colors: [UIColor], start: CGPoint, end: CGPoint) {
        let layer = GradientedLayer(colors: colors, start: start, end: end)
        updateVoxelMaterials(with: layer)
    }
    
    public func paint(face: VoxelFace, with color: UIColor) {
        let layer = ColoredLayer(color: color)
        updateVoxelMaterial(for: face, newContents: layer)
    }
    
    public func paint(face: VoxelFace, with image: UIImage) {
        let layer = TexturedLayer(image: image)
        updateVoxelMaterial(for: face, newContents: layer)
    }
    
    public func paint(face: VoxelFace, with colors: [UIColor], start: CGPoint, end: CGPoint) {
        let layer = GradientedLayer(colors: colors, start: start, end: end)
        updateVoxelMaterial(for: face, newContents: layer)
    }
}


