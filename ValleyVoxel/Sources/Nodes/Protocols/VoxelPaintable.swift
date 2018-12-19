//
//  VoxelPaintable.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/18.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import Foundation
import SceneKit

public enum VoxelPaintCommand {
    
    case color(content: UIColor)
    // Set Color of Specific Face
    case faceColor(content: UIColor, face: VoxelFace)
    case colors(contents: [UIColor])
    
    case image(content: UIImage)
    // Set Image of Specific Face
    case faceImage(content: UIImage, face: VoxelFace)
    case images(contents: [UIImage])
    
    case gradient(contents: [UIColor], start: CGPoint, end: CGPoint)
    // Set Gradient Color of Specific Face
    case faceGradient(contents: [UIColor], start: CGPoint, end: CGPoint, face: VoxelFace)
    
    case transparency(value: CGFloat)
    // Set to be transparent
    case faceTransparency(value: CGFloat, face: VoxelFace)
    
}

public protocol VoxelPaintable {
    
    func apply(_ command: VoxelPaintCommand)
    func apply(_ command: VoxelPaintCommand, animated: Bool, completion: (() -> Void)?)
    
    func paint(with color: UIColor)
    func paint(with image: UIImage)
    func paint(with colors: [UIColor], start: CGPoint, end: CGPoint)
}

extension VKSurfaceDisplayable {
    
    public func apply(_ command: VoxelPaintCommand ) {
        apply(command, animated: false)
    }
    
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
