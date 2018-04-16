//
//  MaterialTextView.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/16.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class MaterialTextView: UITextView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
//        addBorder()
        addBottomBorder()
    }
    
    func addBorder() {
        let layer = self.layer
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        layer.borderWidth = 1
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = 5
    }
    
    func addBottomBorder() {
        let border = UIView()
        border.tag = 1024
        border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        border.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height - 3, width: self.frame.width, height: 3)
        border.backgroundColor = .lightGray
        self.superview!.insertSubview(border, aboveSubview: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        changeColor()
    }
    
    func changeColor() {
        guard let borderView = getsubViews() else { return }
        borderView.backgroundColor = .gray
    }
    
    private func getsubViews() -> UIView? {
        return superview?.subviews.filter{$0.tag == 1024}[0]
    }
    

}
