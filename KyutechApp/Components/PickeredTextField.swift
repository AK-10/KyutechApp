//
//  PickeredTextField.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/06/16.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class PickeredTextField: UITextField {
    
    private var reverseTriangleView: UIImageView! = UIImageView(image: #imageLiteral(resourceName: "textFieldTriangle"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //        下線の追加
        addBorder(side: .bottom, weight: 1, color: .lightGray)
    }

    func commonInit() {
//        画像の色変更
        reverseTriangleView.tintColor = .lightGray
        self.borderStyle = .none
        
//        逆三角形の追加
        self.addSubview(reverseTriangleView)
        reverseTriangleView.translatesAutoresizingMaskIntoConstraints = false
        reverseTriangleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        reverseTriangleView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        reverseTriangleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        reverseTriangleView.widthAnchor.constraint(equalTo: reverseTriangleView.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func getBottomBorder() -> CALayer? {
        let bottomBorder = self.layer.sublayers?.filter{ $0.frame == CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1) }.first
        print(bottomBorder.debugDescription)
        return bottomBorder
    }
}
