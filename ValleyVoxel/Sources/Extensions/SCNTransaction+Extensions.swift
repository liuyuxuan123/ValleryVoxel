//
//  SCNTransaction+Extensions.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/19.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//


import ARKit
import SceneKit

public enum SCNTransactionTimingFunction {
    case linear, easeIn, easeOut, easeInOut, `default`
    
    var value: String {
        switch self {
        case .linear:
            return CAMediaTimingFunctionName.linear.rawValue
        case .easeIn:
            return CAMediaTimingFunctionName.easeIn.rawValue
        case .easeOut:
            return CAMediaTimingFunctionName.easeOut.rawValue
        case .easeInOut:
            return CAMediaTimingFunctionName.easeInEaseOut.rawValue
        case .default:
            return CAMediaTimingFunctionName.default.rawValue
        }
    }
}

extension SCNTransaction {
    // Change
    public static func animate(with duration: TimeInterval,
                               timingFunction: SCNTransactionTimingFunction = .default,
                               _ animation: @escaping () -> Void,
                               _ completion: (() -> Void)? = nil) {
        
        SCNTransaction.begin()
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: timingFunction.value))
        
        SCNTransaction.animationDuration = duration
        animation()
        SCNTransaction.completionBlock = completion
        SCNTransaction.commit()
    }
}

