//
//  ViewController.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/18.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {

    @IBOutlet weak var scnView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = SCNScene()
        scene.rootNode.addChildNode(VoxelTileNode(color: UIColor.red))
        self.scnView.scene = scene  
        self.scnView.allowsCameraControl = true
        self.scnView.autoenablesDefaultLighting = true
        
    }


}

