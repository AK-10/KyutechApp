//
//  MaterialTextView.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/25.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class MaterialTextView: UIView {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var underline: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        super.awakeFromNib()
        let view = Bundle.main.loadNibNamed("MaterialTextView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        addSubview(view)
        
//        view.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//
//        let bindings = ["view": view]
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: bindings))
    }
    
    func beginEditting() {
        UIView.animate(withDuration: 0.4, animations: {
            self.underline.backgroundColor = .cyan
        })
    }
    
    func endEditting() {
        UIView.animate(withDuration: 0.4, animations: {
            self.underline.backgroundColor = .lightGray
        })
    }
    
    
    func setup() {
        let keyboardToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        keyboardToolBar.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let doneButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(tappedDone(_:)))
        keyboardToolBar.items = [spacer, doneButton]
        textView.inputAccessoryView = keyboardToolBar
        
    }
    
    @objc func tappedDone(_ sender: Any) {
        textView.endEditing(true)
        endEditting()
    }
}
