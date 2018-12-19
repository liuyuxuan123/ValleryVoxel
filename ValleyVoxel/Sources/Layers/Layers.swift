//
//  Layers.swift
//  ValleyVoxel
//
//  Created by 刘宇轩 on 2018/12/18.
//  Copyright © 2018 yuxuanliu. All rights reserved.
//

import Foundation
import UIKit

class BorderedLayer: CALayer{
    override var frame: CGRect{
        didSet{
            // Automatically set the border width
            borderWidth = frame.width / 20
        }
    }
    
    override init() {
        super.init()
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.borderColor = UIColor.black.cgColor
        self.shouldRasterize = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ColoredLayer: BorderedLayer {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(color: UIColor) {
        super.init()
        self.backgroundColor = color.cgColor
    }
}

class TexturedLayer: BorderedLayer {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(image: UIImage) {
        super.init()
        
        self.contents = image.cgImage
        self.contentsGravity = CALayerContentsGravity.resizeAspectFill
        self.masksToBounds = true
        self.shouldRasterize = true
    }
}

class GradientedLayer: CAGradientLayer {
    
    override var frame: CGRect {
        didSet { borderWidth = frame.width / 20 }
    }
    
    init(colors: [UIColor]) {
        super.init()
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.borderColor = UIColor.black.cgColor
        self.colors = colors.compactMap { $0.cgColor }
        self.shouldRasterize = true
    }
    
    convenience init(colors: [UIColor], start: CGPoint = .zero, end: CGPoint) {
        self.init(colors: colors)
        self.startPoint = start
        self.endPoint = end
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
