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
// VoxelPaintable -> Can be apply to some command
public protocol VoxelPaintable {
    
    func apply(_ command: VoxelPaintCommand)
    func apply(_ command: VoxelPaintCommand, animated: Bool, completion: (() -> Void)?)
    
    func paint(with color: UIColor)
    func paint(with image: UIImage)
    func paint(with colors: [UIColor], start: CGPoint, end: CGPoint)
}


