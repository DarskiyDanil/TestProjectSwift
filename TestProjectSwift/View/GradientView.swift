//
//  GradientView.swift
//  TestProjectSwift
//
//  Created by  Данил Дарский on 05.03.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

final class GradientView: UIView {
    
    var colors: [UIColor] {
        didSet {
            setupGradient(with: colors)
        }
    }
    
    convenience init(colors: [UIColor]) {
        self.init(colors: colors, frame: .zero)
    }
    
    init(colors: [UIColor], frame: CGRect) {
        self.colors = colors
        super.init(frame: frame)
        setupGradient(with: colors)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    func setupGradient(with colors: [UIColor]) {
        gradientLayer.colors = colors.compactMap { $0.cgColor }
    }
}
