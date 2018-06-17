//
//  PlaceHolderedTextView.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/06/10.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

@IBDesignable
class PlaceHolderedTextView: UITextView {
    
    private lazy var placeholderLabel: UILabel = UILabel()
    
    override var text: String! {
        didSet {
            placeholderLabel.isHidden = (text.count != 0) ? true : false
        }
    }
    
    @IBInspectable
    var placeholder: String = "Place Holder" {
        didSet {
            self.placeholderLabel.text = placeholder
            self.placeholderLabel.sizeToFit()
        }
    }
    
    @IBInspectable
    var placeHolderColor: UIColor = .gray {
        didSet {
            self.placeholderLabel.textColor = placeHolderColor
        }
    }
    
    var placeholderFont: UIFont? = .systemFont(ofSize: 16, weight: .regular) {
        didSet {
            placeholderLabel.font = placeholderFont
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        commonInit()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(TextChanged(notification:)), name: .UITextViewTextDidChange, object: nil)
        self.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        placeholderLabel = UILabel(frame: CGRect(x: 8, y: 5, width: self.bounds.size.width - 16, height: 0))
        placeholderLabel.lineBreakMode = .byCharWrapping
        self.addSubview(placeholderLabel)
    }
    
    @objc func TextChanged(notification: NSNotification) {
        placeholderLabel.isHidden = (0 == text.count) ? false : true
    }

}
