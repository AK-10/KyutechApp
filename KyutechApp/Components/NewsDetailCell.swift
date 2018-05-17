//
//  NewsDetailTableViewCell.swift
//  KyutechApp
//
//  Created by Atsushi KONISHI on 2018/05/11.
//  Copyright © 2018年 小西篤志. All rights reserved.
//

import UIKit

class NewsDetailCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(withDict dict : [String:String]) {
        print(dict)
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .justified
        if dict.count == 2 {
            self.detailLabel.text = dict["content"]
            self.isUserInteractionEnabled = false
        } else if dict.count == 3 {
            self.detailLabel.text = dict["link_name"]
            if !(dict["url"]?.contains("@"))! {
                self.detailLabel.textColor = .blue
                self.isUserInteractionEnabled = true
            }
        }
    }
    
    func didTapped(dict: [String:String]) {
        var url: URL?
        if dict.count == 3 {
            guard let urlString = dict["url"] else { return }
            if urlString.contains("@") {
                return
            }
            url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        }
        guard let URL = url else { return }
        if UIApplication.shared.canOpenURL(URL) {
            UIApplication.shared.open(URL, options: [:], completionHandler: {(isOpenSuccess) in
                if isOpenSuccess {
                    print("successed open \(URL)!")
                } else {
                    print("failed open \(URL)")
                }
            })
        } else {
            print("failed")
        }
        
    }


}
