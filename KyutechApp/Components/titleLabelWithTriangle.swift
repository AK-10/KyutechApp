//
//  titleLabelWithTriangle.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/08/05.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

protocol TitleLabelWithtriangleDelegate: class {
    func setTapLabelAction(_ label: TitleLabelWithTriangle)
}

class TitleLabelWithTriangle: UIView {
    
    weak var delegate: TitleLabelWithtriangleDelegate? = nil
    var titleLabel: UILabel!
    let triangleView: UIImageView! = UIImageView(image: #imageLiteral(resourceName: "reverseTriangle"))
    var triangleStatus: Int = 1
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 112, height: 40)
    }
    
    init(title: String) {
        super.init(frame: CGRect())
        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.sizeToFit()
        titleLabel.textColor = .white
        triangleView.tintColor = .white
        self.isUserInteractionEnabled = true
        self.addSubview(titleLabel)
        self.addSubview(triangleView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        triangleView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: triangleView.leadingAnchor, constant: 0).isActive = true
        triangleView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        triangleView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.sizeToFit()
        
//        self.delegate?.setTapLabelAction(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        self.delegate?.setTapLabelAction(self)
    }
    
    func rotateTriangle() {
        triangleStatus *= -1
        UIView.animate(withDuration: 0.1, animations: {
            self.triangleView.transform = self.triangleStatus < 0 ? CGAffineTransform(rotationAngle: CGFloat.pi) : CGAffineTransform(rotationAngle: 0)
        })
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
