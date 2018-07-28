//
//  NewsDetailViewController+TableView.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/07/29.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import Foundation
import UIKit

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
        paragraphStyle.firstLineHeadIndent = 16
        paragraphStyle.headIndent = 16
        let attributedString = NSAttributedString(string: sections[section], attributes: [.paragraphStyle: paragraphStyle])
        header.attributedText = attributedString
        
        header.backgroundColor = UIColor.extendedInit(from: "#f1f1f1")!
        header.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        header.textColor = .darkGray
        header.textAlignment = .left
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDetailCell", for: indexPath) as! SimpleTableCell
        cell.setup(content: contents[indexPath.section], url: urls[indexPath.section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if urls[indexPath.section] == "" {
            return nil
        } else {
            return indexPath
        }
    }
}
