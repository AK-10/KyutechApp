//
//  SyllabusViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/04/15.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit
import MaterialComponents

class SyllabusViewController: UIViewController {

    @IBOutlet weak var syllabusTable: UITableView!
    @IBOutlet weak var navbar: MaterialNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNavigationBar() {
        guard let navigationItem = navbar.topItem else { return }
        let titleLabel = UILabel()
        titleLabel.text = "Automata"
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel

        let leftButtonItem = UIBarButtonItem(image: UIImage(named: "cancell")! , style: .done, target: self, action: #selector(tappedLeftButton(_:)))

        leftButtonItem.tintColor = .gray
        navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    @objc func tappedLeftButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
