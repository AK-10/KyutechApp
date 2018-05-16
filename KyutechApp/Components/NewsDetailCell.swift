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
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .justified
        if dict.count == 2 {
            self.detailLabel.text = dict["content"]
            self.isUserInteractionEnabled = false
        } else if dict.count == 3 {
            self.detailLabel.text = dict["link_name"]
            self.detailLabel.textColor = .blue
            self.isUserInteractionEnabled = true
        }
    }
    
    func didTapped(dict: [String:String]) {
//        print(dict.count)
        var url: URL?
        if dict.count == 3 {
            let URLhead = "https://db.jimu.kyutech.ac.jp/cgi-bin/cbdb/"
            var contentURL = dict["url"]!
            print(contentURL)
            if contentURL.contains("@") {
                return
            }
            let indexOfFirstSlash = contentURL.index(of: "/")!
            let indexOfFirstQuestion =
                contentURL.index(of: "?")!
            let range = indexOfFirstSlash ..< indexOfFirstQuestion
            contentURL.removeSubrange(range)

            let urlString = URLhead + contentURL
            url = URL(string: urlString)
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
