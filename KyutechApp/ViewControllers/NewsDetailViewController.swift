//
//  NewsDetailViewController.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/06.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var newsItemTable: UITableView!
    var news: News? = nil
    var sections: [String] = []
    var contents: [String] = []
    var urls: [String] = []
    
    deinit {
        print("\(self) deinited")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTable() {
        guard let news = news else { return }
        sections = news.getSections()
        contents = news.getContents()
        urls = news.getURLs()
        
        let nib = UINib(nibName: "SimpleTableCell", bundle: nil)
        newsItemTable.register(nib, forCellReuseIdentifier: "NewsDetailCell")
        newsItemTable.delegate = self
        newsItemTable.dataSource = self
        newsItemTable.estimatedRowHeight = 64
        newsItemTable.rowHeight = UITableViewAutomaticDimension
        newsItemTable.separatorStyle = .none
        newsItemTable.allowsSelection = true

    }

}

