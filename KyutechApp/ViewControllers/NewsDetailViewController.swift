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
    var items: [[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourceSetup()
        setupTable()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTable() {
        let nib = UINib(nibName: "NewsDetailCell", bundle: nil)
        newsItemTable.register(nib, forCellReuseIdentifier: "NewsDetailCell")
        newsItemTable.delegate = self
        newsItemTable.dataSource = self
        newsItemTable.estimatedRowHeight = 40
        newsItemTable.rowHeight = UITableViewAutomaticDimension
        newsItemTable.separatorStyle = .none

    }
    
    func dataSourceSetup() {
        guard let unwrappedNews = news else { return }
        for info in unwrappedNews.infos {
            sections.append(info["title"] ?? "")
        }
        if let attachmentInfos = news?.attachmentInfos {
            for attachedInfo in attachmentInfos {
                sections.append(attachedInfo["title"]!)
            }
            items = unwrappedNews.infos + attachmentInfos
        }
    }

}

extension NewsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 8
        paragraphStyle.headIndent = 8
        let attributedString = NSAttributedString(string: sections[section], attributes: [.paragraphStyle: paragraphStyle])
        header.attributedText = attributedString
        
        
//        header.text = sections[section]
        header.backgroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        header.font = UIFont.systemFont(ofSize: 14)
        header.textColor = .white
//        header.textColor = UIColor(displayP3Red: 48/255, green: 131/255, blue: 251/255, alpha: 1)
        header.textAlignment = .left
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailCell", for: indexPath) as! NewsDetailCell
        let contentData = items[indexPath.section]
        cell.setup(withDict: contentData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if items[indexPath.section].count == 2 {
            return nil
        } else {
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Taaaaaaaaaaped!")
        let cell = tableView.cellForRow(at: indexPath) as! NewsDetailCell
        cell.didTapped(dict: items[indexPath.section])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
