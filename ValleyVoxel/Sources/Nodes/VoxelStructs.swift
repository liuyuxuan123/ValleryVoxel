//
//  VoxelStructs.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/18.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//



import Foundation
import SceneKit

public enum VoxelFace: Int {
    case front  = 0
    case right  = 1
    case back   = 2
    case left   = 3
    case top    = 4
    case bottom = 5
    
    static var all: [VoxelFace] {
        return [front, right, back, left, top, bottom]
    }
    
    var normalizedVector3: SCNVector3 {
        switch self {
        case .front:
            return SCNVector3(0, 0, 1)
        case .right:
            return SCNVector3(1, 0, 0)
        case .back:
            return SCNVector3(0, 0, -1)
        case .left:
            return SCNVector3(-1, 0, 0)
        case .top:
            return SCNVector3(0, 1, 0)
        case .bottom:
            return SCNVector3(0, -1, 0)
        }
    }
    
    var normalizedSimd: simd_float3 {
        switch self {
        case .front:
            return simd_float3(0, 0, 1)
        case .right:
            return simd_float3(1, 0, 0)
        case .back:
            return simd_float3(0, 0, -1)
        case .left:
            return simd_float3(-1, 0, 0)
        case .top:
            return simd_float3(0, 1, 0)
        case .bottom:
            return simd_float3(0, -1, 0)
        }
    }
}

