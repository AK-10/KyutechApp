//
//  PullDownMenuViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/11.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

protocol PullDownMenuViewDelegate: class {
    func setupButtons(_ pullDownMenuView: PullDownMenuViewController)
}

class PullDownMenuViewController: UIViewController {

    @IBOutlet weak var fistButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    weak var delegate: PullDownMenuViewDelegate? = nil
 
    override func viewDidLoad() {

        super.viewDidLoad()
        view.addShadow()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.setupButtons(self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
