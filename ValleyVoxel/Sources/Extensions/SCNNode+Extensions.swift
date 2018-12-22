//
//  SCNNode+Extensions.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/19.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import Foundation
import SceneKit

typealias RenderingCommand = () -> Void

extension SCNNode {
    func process(_ commands: [RenderingCommand], wait duration: TimeInterval = 0.01) {
        var commands = commands
        
        let renderBlock = { (node: SCNNode) in
            guard let command = commands.popLast() else {  return }
            command()
        }
        
        let actions = [SCNAction.wait(duration: duration), SCNAction.run(renderBlock, queue: .main)]
        let sequence = SCNAction.sequence(actions)
        let repeatAction = SCNAction.repeat(sequence, count: commands.count)
        
        runAction(repeatAction)
    }
}
