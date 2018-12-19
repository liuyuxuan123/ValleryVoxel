//
//  VoxelConstants.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/18.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import Foundation
import UIKit

public struct  VoxelConstants{
    public static var debug: Bool = true
    public static var voxelSideLength: CGFloat = 0.025
    
    public static var maxSurfaceWidth: CGFloat = 0.4
    public static var maxSurfaceLength: CGFloat = 0.4
    
    public static let defaultFaceColor = #colorLiteral(red: 0.8666666667, green: 0.2862745098, blue: 0.3137254902, alpha: 1)
    public static let defaultTileColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
    public static let defaultPlatformColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
    
    // typealias TimeInterval = Double
    public static var defaultAnimationDuration: TimeInterval = 0.25
}
