//
//  PickeredTextField.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/06/16.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class PickeredTextField: UITextField {
    
    private var reverseTriangleView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "reverseTriangle"))

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

    func commonInit() {
//        NotificationCenter
//        NotificationCenter.default.addObserver(self, selector: #selector(revertBorderColor), name: Notification.Name.UITextFieldTextDidEndEditing , object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(changeBorderColor(_:)), name: Notification.Name.UITextFieldTextDidBeginEditing, object: nil)
//        self.tintColor = UIColor.extendedInit(from: "#00BCD9")!
//        画像の色変更
        reverseTriangleView.tintColor = .lightGray
        self.borderStyle = .none
//        下線の追加
        addBorder(side: .bottom, weight: 1, color: .lightGray)
        
//        逆三角形の追加
        self.addSubview(reverseTriangleView)
        reverseTriangleView.translatesAutoresizingMaskIntoConstraints = false
        reverseTriangleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        reverseTriangleView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        reverseTriangleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        reverseTriangleView.widthAnchor.constraint(equalTo: reverseTriangleView.heightAnchor, multiplier: 1).isActive = true
    }
    
//    @objc func changeBorderColor(_ sender: Any) {
//        guard let bottomBorder = getBottomBorder() else { return }
//        DispatchQueue.main.async {
//            bottomBorder.backgroundColor = UIColor.extendedInit(from: "#00BCD9")!.cgColor
//        }
//    }
    
//    @objc func revertBorderColor(_ sender: Any) {
//        guard let bottomBorder = getBottomBorder() else { return }
//        DispatchQueue.main.async {
//            bottomBorder.backgroundColor = UIColor.lightGray.cgColor
//        }
//    }
    
    private func getBottomBorder() -> CALayer? {
        let bottomBorder = self.layer.sublayers?.filter{ $0.frame == CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1) }.first
        print(bottomBorder.debugDescription)
        return bottomBorder
    }
}
