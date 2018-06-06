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

extension NewsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 12
        paragraphStyle.headIndent = 12
        let attributedString = NSAttributedString(string: sections[section], attributes: [.paragraphStyle: paragraphStyle])
        header.attributedText = attributedString
        
        
        header.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        header.font = UIFont.systemFont(ofSize: 16)
        header.textColor = .white
//        header.textColor = UIColor(displayP3Red: 48/255, green: 131/255, blue: 251/255, alpha: 1)
        header.textAlignment = .left
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailCell", for: indexPath) as! SimpleTableCell
        cell.setup(content: contents[indexPath.section], url: urls[indexPath.section])
        if indexPath.item == indexPath.last {
            cell.addBorder(sides: [.bottom], weight: 1, color: .gray)
        }
        if indexPath.item == indexPath.last {
            cell.addBorder(sides: [.top], weight: 1, color: .gray)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if urls[indexPath.section] == "" {
            return nil
        } else {
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SimpleTableCell
        print("tapped!")
        cell.didTapped(urlString: urls[indexPath.section])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
